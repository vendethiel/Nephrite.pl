use lib 'lib/';
use Test;
use Text::Nephrite;
use Text::Nephrite::Actions;

sub gram($txt) {
  my $parsed = Text::Nephrite::Grammar.parse($txt, :actions(Text::Nephrite::Actions.new));
  $parsed.ast;
}
#sub tag($tag) {
#  Text::Nephrite::Tag.new(:$tag);
#}
sub doc(|args) {
  Text::Nephrite::Text(|args);
}

plan 2;

my $empty-document = Text::Nephrite::Actions::Document.new();
is gram('').WHAT, Text::Nephrite::Actions::Document, 'Parsing returns a document';
is gram('').children.elems, 0, 'Parsing an empty document returns an empty document';

# TODO, understand how perl6 modules really work, if they work
#is gram('div'), (tag('div'),), 'A single, self-closed tag';

#sub doc-html($doc) {
#  say "
#<html>
#  <body>";
#  to-html($_, 2) for $doc.children;
#  say
#"  </body>
#</html>";
#}
#
#sub to-html($el, $indent) {
#  if $el ~~ Str {
#    say "  " x $indent ~ $el;
#  }
#  else {
#    say "  " x $indent ~ "<{$el.tag}>";
#    to-html($_, $indent + 1) for $el.children;
#    say "  " x $indent ~ "</{$el.tag}>";
#  }
#}
#
#=end
