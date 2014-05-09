grammar Text::Jade::Grammar;

token TOP {
	^^ $$
}

rule ident { :i
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

token filters {
	'[' ~ ']'
	<.ident> '='
	$<val>=[
	| <.quoted-string>
	| <.ident>
	]
}

token selector {
	[
		<id> ?
		<classes> *
		<filters> *
	] * % <.ws>
}