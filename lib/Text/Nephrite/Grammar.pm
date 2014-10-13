grammar Text::Nephrite::Grammar;

my class X::Indent::TooMuch is Exception {
  has $.message;
}

constant TABSTOP = 2;

token TOP {
  :my @*CHILDREN = [];

  <lines>
}

token lines($indent = 0) {
  :my $current = [];
  { @*CHILDREN.push: $current }
  :temp @*CHILDREN = $current;

  <line($indent)> * %% \n
}

proto token line($) { * }

token line:sym<empty>($) {
  ^^ \h * $$ \n
}

token line:sym<full>($indent) {
  ^^ ( [\x20 ** {TABSTOP * $indent}] )
  $<more>=(\h *)
  {
    my $indent = $0.chars div TABSTOP;
    if $<more>.chars {
      die X::Indent::TooMuch.new;
    }
  }
  $$ \n ?

  [
  | <tag> <lines($indent + 1)>
  | <text> <lines($indent + 1)>
    {
      #die X::Indent::TooMuch.new if $<lines>; # what does it return? idk lol
    }
  ] ?
}

token tag {
  \w +
}

token text {
  '|' \N+
}
