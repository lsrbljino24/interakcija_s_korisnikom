# Implementacija koncepata interakcije s korisnikom u iOS aplikacijama

Ovaj tutorijal uključuje teorijske i praktične aspekte interakcije aplikacije i korisnika, odnosno prikazuje kako iOS aplikacija može slati poruke korisniku i kako korisnik može reagirati na njih. Svaki koncept je prvo teorijski objašnjen s preporukama za dizajn, a zatim implementiran u SwiftUI-ju.

## Sadržaj
1. [Uvod](#uvod)
2. [Početni projekt](#korak-1-početni-projekt)
3. [Početna navigacija](#početna-navigacija)
4. [Korak 1: Dijalozi](#korak-1-dijalozi)
5. [Korak 2: Toast](#korak-2-toast)
6. [Korak 3: Snackabr](#korak-3-snackbar)
7. [Korak 4: FAB](#korak-4-fab)
8. [Korak 5: Sistemske notifikacije](#korak-5-sistemske-notifikacije)
9. [Zaključak](#zaključak)
10. [Literatura](#literatura)

## Uvod

Aplikacija stalno komunicira s korisnikom na različite načine:
- potvrđuje da je neka uspjela
- potvrđuje da nije uspjela odnosno javlja grešku
- traži potvrdu za brisanje podataka
- traži potvrdu za nastavak dalje u nekom koraku...

Važno je ispravno implementirati koncepte interakcije tako da manje važne poruke ne prekidaju rad korisnika te tako negativno utječu na korisničko iskustvo, a s druge strane osigurati da važne poruke ne prođu neprimijećeno.

Poruke korisniku možemo podijeliti u dvije skupine:

**Poruke unutar aplikacije** prikazuju se dok korisnik koristi aplikaciju:
- **Dijalozi**: prekidaju rad i traže odgovor korisnika
  (npr. potvrda brisanja).
- **Toast**: nemodalna poruka koja sama nestaje
  (npr. „Spremljeno“).
- **Snackbar**: sličan toastu, ali nudi i jednu akciju
  (npr. „Poruka obrisana – Poništi“).
- **FAB** (Floating Action Button) je istaknuti gumb za glavnu
  radnju na ekranu.

**Sistemske notifikacije**: prikazuje operacijski sustav, pa stižu i kad aplikacija nije otvorena. U ovom tutorijalu obrađujemo lokalne notifikacije u dvije verzije: jednostavnu i složenu (o tome više riječi u koraku #5)


## Početni projekt
...

## Početna navigacija
...

## Korak 1: Dijalozi
...

## Korak 2: Toast
...

## Korak 3: Snackbar
...

## Korak 4: FAB
...

## Korak 5: Sistemske notifikacije
...

## Zaključak
...

## Literatura
...
