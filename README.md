# Implementacija koncepata interakcije s korisnikom u iOS aplikacijama

Ovaj tutorial uključuje teorijske i praktične aspekte interakcije aplikacije i korisnika, odnosno prikazuje kako iOS aplikacija može slati poruke korisniku i kako korisnik može reagirati na njih. Svaki koncept je prvo teorijski objašnjen s preporukama za dizajn, a zatim implementiran u SwiftUI-ju.

## Sadržaj
1. [Uvod](#uvod)
2. [Početni projekt](#početni-projekt)
3. [Početna navigacija](#početna-navigacija)
4. [Korak 1: Dijalozi](#korak-1-dijalozi)
5. [Korak 2: Toast](#korak-2-toast)
6. [Korak 3: Snackbar](#korak-3-snackbar)
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

Toast, snackbar i FAB potječu iz Androida i Material Designa
te nemaju gotovu komponentu u iOS-u. U tutorialu ih zato
implementiramo kao vlastite komponente, uz preporuke iz
Apple Human Interface Guidelines i Material Designa.

Detaljnija objašnjenja slijede u daljnjim koracima tutorijala.

_**Napomena:** Tutorijal se usredotočuje na interakciju aplikacija s korisnikom. osnove jezika Swift i osnove SwiftUI-ja neće se detaljno objašnjavati jer nisu dio ove teme te se pretpostavlja da ih čitatelj već razumije. Objašnjavaju se samo dijelovi koji su izravno vezani uz temu._

## Početni projekt

Kako bi mogli pratiti tutorial, potrebno je kreirati novi projekt:
1. Otvori Xcode i odaberi **File -> New -> Project...**
2. Pod **iOS** odaberi predložak **App** i klikni **Next**.
3. Ispuni sljedeće postavke projekta:

| Postavka | Vrijednost | Objašnjenje |
|---|---|---|
| Product Name | UserInteractionDemo (može biti proizvoljno) | ime aplikacije i projekta |
| Interface | SwiftUI | framework za izradu sučelja |
| Language | Swift | |
| Storage | None | aplikacija ne sprema podatke |

4. Odaberi mapu u kojoj će se projekt spremiti i klikni **Create**

### Početna struktura projeta

```text
interakcija_s_korisnikom/
├── README.md
├── .gitignore
└── UserInterfaceDemo/
    ├── UserInterfaceDemo.xcodeproj
    └── UserInterfaceDemo/
        ├── UserInterfaceDemoApp.swift
        ├── ContentView.swift
        ├── Assets.xcassets/
        └── Preview Content/
            └── Preview Assets.xcassets
```

![Struktura projekta](images/struktura-projekta.png)

#### ContentView.swift
```swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}
#Preview {
    ContentView()
}

```

#### UserInterfaceDemoApp.swift
```swift
import SwiftUI

@main
struct UserInterfaceDemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

Dakle trebali bi imati ovakvu strukturu, izgled prvog ekrana i programski kod navedenih datoteka prije nego se krene sa samim objašnjavanjem teme ovog tutorijala.



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
