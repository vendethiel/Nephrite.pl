grammar Text::Nephrite::Grammar;

my class X::Indent::TooMuch is Exception {
  has $.message;
}

constant TABSTOP = 2;

token TOP {
  <lines> ?
}

token lines($indent = 0) {
  <line($indent)> +
}

# can't proto+arg
#proto token line(Int) { * }
token line(Int $indent) {
  <line-empty> | <line-full($indent)>
}

token line-empty {
  ^^ \h * $$ \n
}

regex line-full($indent) {
  ^^ ( [\x20 ** {TABSTOP * $indent}] )
  $<more>=(\h *)
  {
    # note: my $indent is completely useless here
    my $indent = $0.chars div TABSTOP;
    if $<more>.chars {
      die X::Indent::TooMuch.new;
    }
  }

  [
  | <tag>
  | <text>
  ]

  # \n might be for the next tag at the same level,
  # or for the children
  # NOTE: this means that, yes, it'll backtrack a bit...
  #       the only other solution is to have <line> * %% \n in <lines>
  #       but that gobbles up too much newlines :(
  \n ? <lines($indent + 1)> ?
}

token tag {
  \w +
}

token text {
  '|' \N+
}
