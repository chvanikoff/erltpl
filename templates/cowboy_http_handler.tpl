-module({{MODULE}}).
-author({{AUTHOR}}).

-behaviour(cowboy_http_handler).

%% Cowboy_http_handler callbacks
-export([
	init/3,
	handle/2,
	terminate/2
])

%% API
-export([]).

%% ===================================================================
%% Cowboy_http_handler callbacks
%% ===================================================================

init({tcp, http}, Req, _Opts) ->
	{ok, Req, undefined_state}.

handle(Req, State) ->
	Body = <<"">>,
	{ok, Req2} = cowboy_req:reply(200, [], Body, Req),
	{ok, Req2}.

terminate(_Req, _State) ->
	ok.

%% ===================================================================
%% API functions
%% ===================================================================

