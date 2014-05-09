grammar Text::Jade::Grammar;

token line {
	<selector> <value>
	| '|' <text>
}

regex code {
	<-[\n]>
}

regex text {
	<-[\n]>
	# todo interpolation ...
}

rule value:sym<=> {
	'=' <code>
}

rule value:sym<|> { <text> }

token ident { :i
	<[a..z _ -]>
}

token id {
	'#' <.ident>
}

token class {
	'.' <.ident>
}

token quoted-string:sym<"> {
	'"' ~ '"'
	<-["]>
}

token quoted-string:sym<''> {
	'"' ~ '"'
	<-[']>
}

token attributes:sym<()> {
}

token attributes:sym<{}> {
}

token selector {
	[
		<id> ?
		<classes> *
		<attributes> *
	]
}