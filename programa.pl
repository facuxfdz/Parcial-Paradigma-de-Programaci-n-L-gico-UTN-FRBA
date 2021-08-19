% Apellido y Nombre: Fernández Facundo Agustín
% Legajo: 168081-0

canal(ana,youtube(3000000)).
canal(ana,instagram(2700000)).
canal(ana,tikTok(1000000)).
canal(ana,twitch(2)).
canal(beto,twitch(120000)).
canal(beto,youtube(6000000)).
canal(beto,instagram(1100000)).
canal(cami,tikTok(2000)).
canal(dani,youtube(1000000)).
canal(evelyn,instagram(1)).

redSocial(youtube(_)).
redSocial(instagram(_)).
redSocial(tikTok(_)).
redSocial(twitch(_)).

usuario(Usuario):-
    canal(Usuario,_).

% PUNTO 2) A)
influencer(Usuario):-
    usuario(Usuario), % Tenemos que ligar la variable antes de llegar a totalSeguidores puesto que este no es inversible
    totalSeguidores(Usuario,TotalSeguidores),
    TotalSeguidores > 10000.

totalSeguidores(Usuario,TotalSeguidores):-
    findall(
        Seguidores,
        seguidoresDe(Usuario,Seguidores),
        TodosLosSeguidores
    ),
    sum_list(TodosLosSeguidores, TotalSeguidores).

seguidoresDe(Usuario,Seguidores):-
    canal(Usuario,RedSocial),
    seguidoresSegun(RedSocial,Seguidores).

seguidoresSegun(youtube(Seguidores),Seguidores).
seguidoresSegun(instagram(Seguidores),Seguidores).
seguidoresSegun(tikTok(Seguidores),Seguidores).
seguidoresSegun(twitch(Seguidores),Seguidores).

% PUNTO 2) B)
omnipresente(Usuario):-
    usuario(Usuario),
    forall(redSocial(RedSocial),canal(Usuario,RedSocial)).

% PUNTO 2) C)
exclusivo(Usuario):-
    canal(Usuario,RedSocial),
    not((canal(Usuario,OtraRedSocial), RedSocial \= OtraRedSocial)).

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