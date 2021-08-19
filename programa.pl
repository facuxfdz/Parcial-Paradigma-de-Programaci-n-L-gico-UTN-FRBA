% Apellido y Nombre: Fernández Facundo Agustín
% Legajo: 168081-0

canal(ana,youtube,3000000).
canal(ana,instagram,2700000).
canal(ana,tikTok,1000000).
canal(ana,twitch,2).
canal(beto,twitch,120000).
canal(beto,youtube,6000000).
canal(beto,instagram,1100000).
canal(cami,tikTok,2000).
canal(dani,youtube,1000000).
canal(evelyn,instagram,1).

% redSocial(youtube(_)).
% redSocial(instagram(_)).
% redSocial(tikTok(_)).
% redSocial(twitch(_)).

redSocial(RedSocial):-
    distinct(RedSocial,canal(_,RedSocial,_)).

usuario(Usuario):-
    canal(Usuario,_,_).

% PUNTO 2) A)
influencer(Usuario):-
    usuario(Usuario), % Tenemos que ligar la variable antes de llegar a totalSeguidores puesto que este no es inversible
    totalSeguidores(Usuario,TotalSeguidores),
    TotalSeguidores > 10000.

totalSeguidores(Usuario,TotalSeguidores):-
    findall(
        Seguidores,
        canal(Usuario,_,Seguidores),
        TodosLosSeguidores
    ),
    sum_list(TodosLosSeguidores, TotalSeguidores).



% PUNTO 2) B)
omnipresente(Usuario):-
    usuario(Usuario),
    forall(redSocial(RedSocial),canal(Usuario,RedSocial,_)).

% PUNTO 2) C)
exclusivo(Usuario):-
    canal(Usuario,RedSocial,_),
    not((canal(Usuario,OtraRedSocial,_), RedSocial \= OtraRedSocial)).

% PUNTO 3)

contenido(ana,tikTok,video([beto,evelyn],1)).
contenido(ana,tikTok,video([ana],1)).
contenido(ana,instagram,foto([ana])).
contenido(beto,instagram,foto([])).
contenido(cami,twitch,stream(leagueOfLegends)).
contenido(cami,youtube,video([cami],5)).
contenido(evelyn,instagram,foto([evelyn,cami])).


tematica(juego,leagueOfLegends).
tematica(juego,minecraft).
tematica(juego,aoe).

adictiva(RedSocial):-
    redSocial(RedSocial),
    forall(
        contenido(_,RedSocial,Contenido),
        contenidoAdictivo(Contenido)
    ).

contenidoAdictivo( video(_,Duracion) ):-
    Duracion < 3.

contenidoAdictivo( stream(Tematica) ):-
    tematica(juego,Tematica).

contenidoAdictivo( foto(Participantes) ):-
    length(Participantes, CantidadParticipantes),
    CantidadParticipantes < 4.

colaboran(Usuario,OtroUsuario):-
    contenido(Usuario,_,Contenido).
