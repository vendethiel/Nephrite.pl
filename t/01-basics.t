use lib 'lib/';
use Test;
use Text::Nephrite;

sub gram($txt) {
  my $parsed = Text::Nephrite::Grammar.parse($txt, :actions(Text::Nephrite::Actions.new));
  $parsed.ast;
}

sub doc-html($doc) {
  say "
<html>
  <body>";
  to-html($_, 2) for $doc.children;
  say
"  </body>
</html>";
}

sub to-html($el, $indent) {
  if $el ~~ Str {
    say "  " x $indent ~ $el;
  }
  else {
    say "  " x $indent ~ "<{$el.tag}>";
    to-html($_, $indent + 1) for $el.children;
    say "  " x $indent ~ "</{$el.tag}>";
  }
}

#sub tag($tag) {
#  Text::Nephrite::Tag.new(:$tag);
#}

plan 1;

say (my $a = gram(
"div
  foo
    xd
      mdr

      lol

  bar
  baz"
)).perl;
say doc-html($a);
is 1, 1;
#is gram('div'), (tag('div'),), 'A single, self-closed tag';
