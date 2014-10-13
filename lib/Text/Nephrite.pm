module Text::Nephrite;

use Text::Nephrite::Grammar;
#use Text::Nephrite::Actions;

sub parse(Str $txt) is export {
  # --> :(Hash[Str, Str] --> Str)) is export {
	my $actions = Text::Nephrite::Actions.new();
	my $parsed = Text::Nephrite::Grammar.parse($txt);
	return $parsed.ast;
}
