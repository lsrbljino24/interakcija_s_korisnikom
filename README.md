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

Prije implementacije pojedinih koncepata potrebno je napraviti početni ekran s kojeg se može doći do svakog primjera. Svaki koncept dobiva vlastiti ekran, tako da je kod pregledan i primjeri su međusobno odvojeni. To je implementirano tako da je na početnom ekranu napravljena jednostavna navigacija koja vodi do svakog primjera i nazad.

### 1. Mapa za ekrane

Kako bi projekt ostao organiziran, s svi se ekrani spremaju u zajedničku mapu. U gornjem lijevom stupcu napravi klik na mapu _UserInterfaceDemo_ i odaberi **New Folder** te ga nazovi _Screens_. Također napravi i mape _Components_ i _Notifications_ koje ćemo koristiti kasnije za toast, snackbar i FAB kao komponente koje se mogu ponovo koristiti te za logiku notifikacija.

### 2. Prazni ekrani

Za svaki koncept napravi prazan ekran koji će se popunjavati u sljedećim
koracima. Desni klik na mapu _Screens_ → **New File from Template…** →
**SwiftUI View**.

Napravi sljedeće datoteke:

| Datoteka | Koncept |
|---|---|
| _DialogsScreen.swift_ | korisnički dijalozi |
| _ToastScreen.swift_ | toast poruke |
| _SnackbarScreen.swift_ | snackbar poruke |
| _FABScreen.swift_ | Floating Action Button |
| _SimpleNotificationScreen.swift_ | jednostavna sistemska notifikacija |
| _RichNotificationScreen.swift_ | složena sistemska notifikacija |

Sada bi stablo direktorija trebalo izgledati ovako: 

```text
interakcija_s_korisnikom/
├── README.md
├── .gitignore
├── images/
└── UserInterfaceDemo/
    ├── UserInterfaceDemo.xcodeproj
    └── UserInterfaceDemo/
        ├── UserInterfaceDemoApp.swift
        ├── ContentView.swift
        ├── Components/
        ├── Notifications/
        ├── Screens/
        │   ├── DialogsScreen.swift
        │   ├── ToastScreen.swift
        │   ├── SnackbarScreen.swift
        │   ├── FABScreen.swift
        │   ├── SimpleNotificationScreen.swift
        │   └── RichNotificationScreen.swift
        ├── Assets.xcassets/
        └── Preview Content/
            └── Preview Assets.xcassets
```

Svaki ekran za sada sadrži samo tekst i naslov: 
```swift
import SwiftUI

struct DialogsScreen: View {
    var body: some View {
        Text("Ovdje dolaze primjeri dijaloga.")
            .navigationTitle("Dijalozi")
    }
}

#Preview {
    NavigationStack {
        DialogsScreen()
    }
}
```
_.navigationTitle_ postavlja naslov koji se prikazuje u navigacijskoj traci kad se ekran otvori.
U _#Preview_ je ekran omotan u _NavigationStack_ kako bi se naslov vidio i u Canvasu s desne strane.

Ostale ekrane napravi na sličan način, dakle mijenjaj samo naziv structa, tekst i naslov, npr. za FABScreen promijeni _struct DialogsScreen:_ u _struct FABScreen:_...

### 3. Navigacija pomoću NavigationStack

Početni ekran (_ContentView_) prikazuje listu primjera u obliku jednostavne navigacije koja je implementirana pomoću _NavigationStack_. 

ContentView.swift

```swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Poruke unutar aplikacije") {
                    NavigationLink {
                        DialogsScreen()
                    } label: {
                        Label("Dijalozi", systemImage: "exclamationmark.bubble")
                    }

                    NavigationLink {
                        ToastScreen()
                    } label: {
                        Label("Toast", systemImage: "text.bubble")
                    }

                    NavigationLink {
                        SnackbarScreen()
                    } label: {
                        Label("Snackbar", systemImage: "square.bottomhalf.filled")
                    }

                    NavigationLink {
                        FABScreen()
                    } label: {
                        Label("FAB", systemImage: "plus.circle.fill")
                    }
                }

                Section("Sistemske notifikacije") {
                    NavigationLink {
                        SimpleNotificationScreen()
                    } label: {
                        Label("Jednostavna notifikacija", systemImage: "bell")
                    }

                    NavigationLink {
                        RichNotificationScreen()
                    } label: {
                        Label("Složena notifikacija", systemImage: "bell.badge")
                    }
                }
            }
            .navigationTitle("Interakcija s korisnikom")
        }
    }
}

#Preview {
    ContentView()
}
```
Dakle _NavigationStack_ upravlja navigacijom tako da kad korisnik otvori novi ekran on se postavlja na vrh stoga, a gumb za povratak (gore lijevo) ga uklanja. Gumb se dodaje automatski. 

_List_ prikazuje retke u obliku obične iOS liste.

_NavigationLink_ je redak koji na dodir otvara novi ekran. Prvi dio određuje odredište, npr. _DialogsScreen()_, a _Label_ ono što se prikazuje u retku. _Label_ prikazuje tekst s ikonom, a koje dolaze iz Appleove biblioteke **SF Symbols**.

Također, koristeći _Section_, u svrhu jednostavnijeg praćenja, primjeri su podijeljeni u dvije skupine: Poruke unutar aplikacije i Sistemske notifikacije.

Na kraju, pokrenemo aplikaciju koja treba izgledati prema sljedećim slikama:

| Početni ekran | Otvoreni ekran |
|---|---|
| ![Početni ekran](images/pocetni-ekran.png) | ![Ekran dijaloga](images/ekran-dijalozi.png) |


Sad kada smo pripremili početnu aplikaciju, možemo krenuti s primjerima.

[↑ Natrag na sadržaj](#sadržaj)

## Korak 1: Dijalozi

Dijalog je **modalni** element sučelja koji se prikazuje iznad trenutnog sadržaja i prekida korisnika dok ne odgovori ili ga ne zatvori. Stoga može biti vrlo koristan, ali i nametljiv. Koristi se kada aplikacija treba korisniku reći nešto važno ili od njega tražiti odluku prije nego nastavi.

U iOS-u postoje tri osnovna oblika dijaloga: 
| Vrsta | Izgled | Kada se koristi | SwiftUi |
|---|---|---|---|
| **Alert** | mali okvir u sredini ekrana | važna informacija ili potvrda radnje | _.action_|
| **Action sheet** (**Donfirmation Dialog**) | izbornik koji izlazi s dna ekrana | izbor između više radnji vezanih uz radnju koju je korisnik pokrenuo | _.confirmationDialog_ |
| **Sheet** | ploča preko dijela ili cijelog ekrana | kratak, zaokružen zadatak vezan uz trenutni kontekst (npr. obrazac) | _.sheet_ |

### Preporuke dizajna

Preporuke su preuzete iz Apple Human Interface Guidelines.
_(Poveznica u sekciji [Literatura](#sadržaj) )_

**Alert**
- Koristi ga štedljivo. Alert prekida korisnika, pa svaki treba sadržavati
  samo bitne informacije i korisne radnje. Ako se alerti pojavljuju
  prečesto, korisnici ih počnu zatvarati bez čitanja.
- Ne prikazuj alert za česte radnje koje se mogu poništiti, čak ni kad
  su destruktivne. Primjer: brisanje e-maila ne traži potvrdu jer se
  može vratiti iz smeća.
- Alert ima naslov, neobavezni tekst poruke i najviše tri gumba.
  Na iOS-u može sadržavati i polje za unos teksta.
- Nazivi gumba trebaju biti kratki (jedna ili dvije riječi) i opisivati
  rezultat: „Obriši“ je bolje od „Da“.
- Ako korisnik bira između više od dva izbora, bolje je koristiti
  action sheet.

**Action Sheet** (**Confirmation Dialog**)
- Koristi ga za izbore vezane uz radnju koju je korisnik sam pokrenuo.
  Primjer: kad korisnik zatvara nedovršenu poruku, nudi se „Spremi skicu“
  ili „Obriši skicu“.
- Gumb za odustajanje nalazi se na dnu. U SwiftUI-ju ga confirmation
  dialog dodaje automatski.
- Uz gumb za odustajanje ponudi najviše tri dodatna izbora.

**Sheet**
- Koristi ga za kratak zadatak usko vezan uz trenutni kontekst,
  npr. unos komentara ili uređivanje jednog podatka.
- Sheet treba imati gumb za odustajanje koji ga zatvara bez spremanja
  promjena.

**Uloge gumba**

SwiftUI gumbima može dodijeliti ulogu (_role_):
- _.destructive_ – gumb briše podatke ili izvodi nepovratnu radnju;
  sustav ga prikazuje crveno
- _.cancel_ – gumb zatvara dijalog bez ikakve radnje; sustav ga sam
  postavlja na uobičajeno mjesto

Zahvaljujući ulogama, dijalozi automatski prate sistemski izgled
i ponašanje, a korisnik odmah prepoznaje opasnu radnju.

### Korak 1.1: Priprema ekrana

 🔗 [Commit za ovaj korak](https://github.com/lsrbljino24/interakcija_s_korisnikom/commit/ecf5f0)

Ekran _DialogsScreen_ prikazuje listu gumba, a svaki otvara jedan primjer dijaloga. Na dnu se prikazuje zadnja reakcija korisnika, kako bi se vidjelo koji je gumb u dijalogu odabran.

Dakle pripremi DialogsScreen.swift kako je prikazano ispod:
```swift
import SwiftUI

struct DialogsScreen: View {
    // varijable stanja idu ovdje
    @State private var lastAction = "Još nije odabrana nijedna radnja."

    var body: some View {
        List {
            // gumbi na ekranu idu ovdje
            Section("Zadnja reakcija korisnika") {
                Text(lastAction)
                    .foregroundStyle(.secondary)
            }
        }
        .navigationTitle("Dijalozi")
        // dijalozi idu ovdje
    }
}
```
Svaki dijalog u SwiftUI-ju prikazuje se na isti način:
1. varijabla stanja tipa _Bool_ određuje je li dijalog vidljiv
2. gumb na ekranu postavlja tu varijablu na _true_
3. modifikator dijaloga (_.alert_, _.confirmationDialog_, _.sheet_)
   prima tu varijablu kao **binding** (_$_) i prikazuje dijalog
4. kad korisnik odabere gumb u dijalogu, SwiftUI sam vraća varijablu
   na _false_ i zatvara dijalog

U sljedeća tri koraka su objašnjena tri tipa Alerta.

### Korak 1.2: Informativni alert

🔗 [Commit za ovaj korak](https://github.com/lsrbljino24/interakcija_s_korisnikom/commit/48b9d4d)

Najjednostavniji alert koji obavještava korisnika o važnom događaju
i ima samo jedan gumb.

Dodaj varijablu stanja:
```swift
@State private var showInfoAlert = false
```

Dodaj sekciju s gumbom na vrh liste:
```swift
Section("Alert") {
    Button("Informativni alert") {
        showInfoAlert = true
    }
}
```

Dodaj modifikator nakon _.navigationTitle_:
```swift
.alert("Nema internetske veze", isPresented: $showInfoAlert) {
    Button("U redu") {
        lastAction = "Korisnik je potvrdio informativni alert."
    }
} message: {
    Text("Provjerite vezu i pokušajte ponovno.")
}
```
- Prvi parametar je **naslov** alerta.
- _isPresented: $showInfoAlert_ povezuje alert s varijablom stanja.
- U prvom bloku su **gumbi**, a u bloku _message_ **tekst poruke**.

Primjer prati preporuku da alert sadrži važnu informaciju, dakle korisnik
mora znati da nema internetske veze jer o tome ovisi što može dalje raditi.

Kako bi testirali implementirani kod, navigiramo se s početnog ekrana u sekciju _Dijalozi_ nakon čega odaberemo opciju _Informativni alert_ što nam prikaže sami alert na kojemu odaberemo opciju _U redu_. Možemo primijetiti kako se u _Zadnju reakciju korisnika_ upiše _Korisnik je potvrdio informativni alert_

<img src="images/alert-informativni.png" alt="Alert informativni" width="400">

### 1.3 Alert za potvrdu destruktivne radnje

🔗 [Commit za ovaj korak](https://github.com/lsrbljino24/interakcija_s_korisnikom/commit/cfce10c)

Kada radnja nepovratno briše podatke, alert traži potvrdu korisnika.

```swift
@State private var showDeleteAlert = false
```

```swift
Button("Potvrda brisanja") {
    showDeleteAlert = true
}
```

```swift
.alert("Obrisati fotografiju?", isPresented: $showDeleteAlert) {
    Button("Obriši", role: .destructive) {
        lastAction = "Korisnik je obrisao fotografiju."
    }
    Button("Odustani", role: .cancel) {
        lastAction = "Korisnik je odustao od brisanja."
    }
} message: {
    Text("Ova radnja se ne može poništiti.")
}
```

- _role: .destructive_ prikazuje gumb crveno i upozorava korisnika.
- _role: .cancel_ označava gumb za odustajanje. Sustav ga sam postavlja
  na uobičajeno mjesto, bez obzira na redoslijed u kodu.
- Gumbi su nazvani prema rezultatu („Obriši“, „Odustani“), a ne
  „Da“ i „Ne“.
- Poruka objašnjava posljedicu, što je razlog za prikaz alerta:
  radnja se ne može poništiti.

<img src="images/alert-brisanje.png" alt="Alert za potvrdu brisanja" width="400">

### 1.4 Alert s unosom teksta

🔗 [Commit za ovaj korak](https://github.com/lsrbljino24/interakcija_s_korisnikom/commit/906ee3a)

Na iOS-u alert može sadržavati polje za unos teksta, što je korisno
za kratak unos poput novog naziva.

```swift
@State private var showRenameAlert = false
@State private var newName = ""
```

```swift
Button("Alert s unosom teksta") {
    newName = ""
    showRenameAlert = true
}
```

```swift
.alert("Preimenuj album", isPresented: $showRenameAlert) {
    TextField("Novi naziv", text: $newName)
    Button("Spremi") {
        lastAction = "Novi naziv albuma: \(newName)"
    }
    Button("Odustani", role: .cancel) {
        lastAction = "Korisnik je odustao od preimenovanja."
    }
} message: {
    Text("Unesite novi naziv albuma.")
}
```

- _TextField_ unutar bloka gumba prikazuje polje za unos u alertu.
- Tekst se sprema u varijablu _newName_ preko bindinga _$newName_.
- Prije otvaranja alerta polje se prazni, kako ne bi ostao tekst
  od prošlog unosa.


<img src="images/alert-unos.png" alt="Alert s unosom" width="400">

### 1.5 Confirmation dialog (action sheet)

🔗 [Commit za ovaj korak](https://github.com/lsrbljino24/interakcija_s_korisnikom/commit/e014252)

Kada korisnik pokrene radnju koja ima više mogućih ishoda, koristi se
confirmation dialog, koji se na iPhoneu prikazuje kao action sheet
s dna ekrana.

```swift
@State private var showDraftDialog = false
```

```swift
Section("Confirmation dialog") {
    Button("Zatvori skicu poruke") {
        showDraftDialog = true
    }
}
```

```swift
.confirmationDialog(
    "Što želite napraviti sa skicom?",
    isPresented: $showDraftDialog,
    titleVisibility: .visible
) {
    Button("Spremi skicu") {
        lastAction = "Skica je spremljena."
    }
    Button("Obriši skicu", role: .destructive) {
        lastAction = "Skica je obrisana."
    }
    Button("Odustani", role: .cancel) {
        lastAction = "Korisnik je nastavio uređivati poruku."
    }
} message: {
    Text("Poruka još nije poslana.")
}
```
- Naslov se na iPhoneu po defaultu ne prikazuje, pa ga
  _titleVisibility: .visible_ uključuje.
- Gumb s ulogom _.cancel_ prikazuje se odvojeno na dnu. Kad bi se
  izostavio, SwiftUI bi ga dodao automatski.
- Primjer ima dva izbora uz odustajanje, što je unutar preporučenog
  broja izbora.

<img src="images/confirmation-dialog.png" alt="Confirmation dialog" width="400">

### 1.6 Sheet

🔗 [Commit za ovaj korak](https://github.com/lsrbljino24/interakcija_s_korisnikom/commit/a53d6a6)

Sheet se koristi kada dijalog sadrži više od par gumba, npr. obrazac.

```swift
@State private var showSheet = false
@State private var comment = ""
```

```swift
Section("Sheet") {
    Button("Pošalji povratnu informaciju") {
        comment = ""
        showSheet = true
    }
}
```

```swift
.sheet(isPresented: $showSheet) {
    NavigationStack {
        Form {
            TextField("Vaš komentar", text: $comment, axis: .vertical)
        }
        .navigationTitle("Povratna informacija")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Odustani") {
                    lastAction = "Korisnik je odustao od slanja komentara."
                    showSheet = false
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Pošalji") {
                    lastAction = "Poslan komentar: \(comment)"
                    showSheet = false
                }
                .disabled(comment.isEmpty)
            }
        }
    }
    .presentationDetents([.medium])
}
```

- Sadržaj sheeta je običan SwiftUI view, pa može sadržavati bilo što.
- Za razliku od alerta, sheet se ne zatvara sam, nego ga zatvara
  postavljanje _showSheet = false_.
- _.cancellationAction_ i _.confirmationAction_ postavljaju gumbe na
  uobičajena mjesta u navigacijskoj traci (lijevo odustajanje,
  desno potvrda).
- _.disabled(comment.isEmpty)_ onemogućuje slanje praznog komentara.
- _.presentationDetents([.medium])_ prikazuje sheet preko pola ekrana,
  tako da korisnik i dalje vidi kontekst ispod njega.

<img src="images/sheet.png" alt="Sheet" width="400">

### Završni izgled ekrana

| Ekran s primjerima | Alert | Confirmation dialog | Sheet |
|---|---|---|---|
| ![](images/dijalozi-ekran.png) | ![](images/alert-brisanje.png) | ![](images/confirmation-dialog.png) | ![](images/sheet.png) |

[↑ Natrag na sadržaj](#sadržaj)

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
