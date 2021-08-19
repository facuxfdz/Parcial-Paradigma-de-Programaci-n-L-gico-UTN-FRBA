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

:- begin_tests(punto_1_a).

test(usuario_con_mas_de_10000_seguidores_es_influencer):-
    influencer(dani).

test(usuario_con_menos_de_10000_seguidores_no_es_influencer, fail):-
    influencer(evelyn).

:- end_tests(punto_1_a).

omnipresente(Usuario):-
    usuario(Usuario),
    forall(redSocial(RedSocial),canal(Usuario,RedSocial)).
