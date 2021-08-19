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
    forall(
        redSocial(RedSocial),
        canal(Usuario,RedSocial,_)
    ).

% PUNTO 2) C)
exclusivo(Usuario):-
    canal(Usuario,RedSocial,_),
    not((
        canal(Usuario,OtraRedSocial,_), 
        RedSocial \= OtraRedSocial
    )).

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

% PUNTO 4
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

% PUNTO 5
colaboran(Usuario,OtroUsuario):-
    contenido(Usuario,_,Contenido),
    apareceEn(Contenido,OtroUsuario).

colaboran(Usuario,OtroUsuario):-
    contenido(OtroUsuario,_,Contenido),
    apareceEn(Contenido,Usuario).

apareceEn(foto(Participantes),Usuario):-
    member(Usuario, Participantes).
    
apareceEn(video(Participantes,_),Usuario):-
    member(Usuario, Participantes).


% PUNTO 6
caminoALaFama(Usuario):-
    usuario(Usuario),
    not(influencer(Usuario)),
    influencer(Influencer),
    colaboran(Usuario,Influencer).

caminoALaFama(Usuario):-
    usuario(Usuario),
    not(influencer(Usuario)),
    influencer(Influencer),
    colaboran(Influencer,OtroUsuario),
    caminoALaFama(OtroUsuario).



% PUNTO 7 A)
:- begin_tests(punto_7_a).

test(redes_sociales_adictivas, set(RedesSociales=[instagram,tikTok,twitch])):-
    adictiva(RedesSociales).

:- end_tests(punto_7_a).

% PUNTO 7) B)
% Prolog trabaja bajo el concepto de universo cerrado, es decir, todo hecho que no esté en nuestra base de conocimientos no existe o en tal caso será falsa cualquier consulta que sobre el se haga.
% Es por esto que si necesitamos decir que "algo no es así" basta con no agregarlo en la base de conocimientos, pues el motor de inferencia de Prolog tomará cualquier hecho que no se escriba como false.
