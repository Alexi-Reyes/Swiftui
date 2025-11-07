# Swiftui

## Description

Simple pokédex pour IOS

## Installation

```shell
git clone git@github.com:Alexi-Reyes/Swiftui.git
cd Swiftui/
```

## Equipe

Enguerrand Cousin
Alexi Reyes

## Point d'amélioration

Le projet possède un package avec DesignSystem, mais il pourrait avoir plus de composants et être plus générique afin de permettre de les réutiliser dans d'autres projets. Rajouter plus de packages par rapport aux features ou pages. Rajouter plus de composants serait bien.

Une architecture MVVM a été utilisée mais il reste des points d'amélioration notamment une plus grande séparation des viewModel de leur composant, un nommage plus parlant.

La page de description fait trois requêtes différentes au lieu d'une seule et de passer la donnée aux composants, il faut changer cela.

La barre de recherche filtre les pokemons déjà recu, il serait intéressant de faire une requête différente de celle d'initialisation pour la recherche et/ou filtre  afin d'avoir plus de rapidité sur le traitement des filtres.

Le projet possède des tests unitaires avec des mocks mais uniquement PokemonViewModel est testé, il faudrait en ajouter plus. Les tests possèdent de la duplication de code provenant de l'application, ce qui n'est pas ideal, une refactorisation est nécessaire. Il y a eu une tentative d'utiliser des imports, mais cela entraînait des problèmes plus loin et il y a eu un manque de temps pour les corriger.

Nous n'avons pas utilisé actor, combine et ne possédons pas de package core regroupant repository, service et model.

Note possible 14.
