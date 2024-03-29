-module({{MODULE}}).
-author({{AUTHOR}}).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    {{MODULE}}_sup:start_link().

stop(_State) ->
    ok.