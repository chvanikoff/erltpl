#!/usr/bin/env escript
%% -*- erlang -*-

-define(DEFAULT_TPL, "default").
-define(AUTHOR, <<"'chvanikoff <chvanikoff@gmail.com>'">>).

main([Module | Tpl]) ->
	main(Module, Tpl);
main(_) ->
	usage().

usage() ->
	io:format("Usage: ~p <module> [<template> = default]~n", [escript:script_name()]).

main(Module, []) ->
	run(Module, ?DEFAULT_TPL);
main(Module, Tpl) ->
	[Tpl2] = Tpl,
	run(Module, Tpl2).

run(Module, Tpl) ->
	{ok, Bin} = file:read_file(get_real_path() ++ "templates/" ++ Tpl ++ ".tpl"),
	Replacements = [
		{<<"{{AUTHOR}}">>, ?AUTHOR},
		{<<"{{MODULE}}">>, list_to_binary(Module)}
	],
	NewBin = replace_tpl_vars(Bin, Replacements),
	ok = file:write_file(Module ++ ".erl", NewBin).

replace_tpl_vars(Bin, [Replacement | []]) ->
	{From, To} = Replacement,
	bin_replace(Bin, From, To);
replace_tpl_vars(Bin, [Replacement | Rest]) ->
	{From, To} = Replacement,
	replace_tpl_vars(bin_replace(Bin, From, To), Rest).

bin_replace(Binary, From, To) ->
	bin_replace(Binary, byte_size(From), Binary, From, To, 0).

bin_replace(Binary_origin, From_length, Binary, From, To, Counter) ->
	case Binary of
		<<From:From_length/binary, Right/binary>> ->
			OtherRepl = bin_replace(Right, From, To),
			<<Left:Counter/binary, _/binary>> = Binary_origin,
			<<Left/binary, To/binary, OtherRepl/binary>>;
		<<_:8, Other/binary>> ->
			bin_replace(Binary_origin, From_length, Other, From, To, Counter + 1);
		<<>> ->
			Binary_origin
	end.

get_real_path() ->
	File = os:cmd("readlink " ++ escript:script_name()),
	get_real_path(lists:reverse(File)).

get_real_path([$/ | _T] = Path) ->
	lists:reverse(Path);
get_real_path([_H | T]) ->
	get_real_path(T).
