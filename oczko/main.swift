var stos = Set<String>()
var gracz = Set<String>()
var komp = Set<String>()

var gracz_sum = 0
var komp_sum = 0

let symbols = ["♠", "♥", "♦", "♣"]
let other = ["J", "Q", "K", "A"]

for s in symbols{
    for i in 2...10{
        stos.insert(s+String(i))
    }
}
for s in symbols{
    for i in other{
        stos.insert(s+i)
    }
}

var stos_start = stos

func dobierz() -> String{
    let karta = stos.randomElement()
    stos.remove(karta!)
    return karta!
}

func dodaj(suma: Int, karta: String) -> Int{
    if(karta.contains("A")){
        return (suma + 11)
    }
    else if(karta.contains("K")){
        return (suma + 4)
    }
    else if(karta.contains("Q")){
        return (suma + 3)
    }
    else if(karta.contains("J")){
        return (suma + 2)
    }
    else if(karta.contains("0")){
        return (suma + 10)
    }
    else if(karta.contains("9")){
        return (suma + 9)
    }
    else if(karta.contains("8")){
        return (suma + 8)
    }
    else if(karta.contains("7")){
        return (suma + 7)
    }
    else if(karta.contains("6")){
        return (suma + 6)
    }
    else if(karta.contains("5")){
        return (suma + 5)
    }
    else if(karta.contains("4")){
        return (suma + 4)
    }
    else if(karta.contains("3")){
        return (suma + 3)
    }
    else if(karta.contains("2")){
        return (suma + 2)
    }
    return suma
}

func perskieOczko(secik: Set<String>) -> Bool{
    if(secik.count == 2){
        var noOfas = 0 
        for card in secik{
            if(card.contains("A")){
                noOfas = noOfas + 1
            }
            if(noOfas == 2){
                print("PERSKIE OCZKO")
                return true
            }
        }
    }
    return false
}

// Wstep

print("Witaj w grze OCZKO")
print("Wartości kart:\nKarty 2-10 mają wartość równą wartości karty\nJ(walet) ma wartość 2pkt\nQ(dama) ma wartość 3pkt\nK(król) ma wartość 4pkt\nA(as) ma wartość 11pkt")
print()
print("Zaczynasz z dwoma kartami")
print()

// Tura gracz

var gracz_perskie = false
var gracz_przegrana = false
var pass = false
print("Gracz dobiera:")
var dobrano = dobierz()
gracz.insert(dobrano)
gracz_sum = dodaj(suma: gracz_sum, karta: dobrano)
print("Dobrano:", dobrano)
print("Aktualna ręka:", gracz, "Suma:", gracz_sum)
while(!pass){
    dobrano = dobierz()
    gracz.insert(dobrano)
    gracz_sum = dodaj(suma: gracz_sum, karta: dobrano)
    print("Dobrano:", dobrano)
    print("Aktualna ręka:", gracz, "Suma:", gracz_sum)

    print("Zamierzasz kontynuować? [T/N]")
    var a = true
    while(a){
        let wybor = (readLine()!).lowercased()
        switch(wybor){
            case "t":
                a = false 
                continue
            case "n":
                a = false 
                pass = true
            default:
                print("Zły wybór")
        }
    }
    
    if(perskieOczko(secik: gracz)){
        gracz_perskie = true
        pass = true
    }
    else if(gracz_sum > 21)
    {
        print("Suma twoich kart wynosi więcej niż 21!")
        gracz_przegrana = true
        pass = true
    }
}
print("PASS")
print()

// Tura komp

var komp_perskie = false
var komp_przegrana = false
pass = false
print("Komputer dobiera:")
dobrano = dobierz()
komp.insert(dobrano)
komp_sum = dodaj(suma: komp_sum, karta: dobrano)
print("Dobrano:", dobrano)
print("Aktualna ręka:", komp, "Suma:", komp_sum)
while(!pass){
    dobrano = dobierz()
    komp.insert(dobrano)
    komp_sum = dodaj(suma: komp_sum, karta: dobrano)
    print("Dobrano:", dobrano)
    print("Aktualna ręka:", komp, "Suma:", komp_sum)

    if(perskieOczko(secik: komp)){
        komp_perskie = true
        pass = true
    }
    else if(komp_sum > 21){
        komp_przegrana = true
        pass = true
    }
    else if(komp_sum > 15 && gracz.count < 4){
        pass = true
    }
    else if(komp_sum >= 18){
        pass = true
    }
}
print("PASS")
print()

// Wygrany

if(gracz_perskie && komp_perskie){
    print("Wygrana z obu stron!")
}
else if(gracz_perskie){
    print("Wygrałeś!")
}
else if(komp_perskie){
    print("Komputer wygrał.")
}
else if(komp_przegrana && gracz_przegrana){
    print("Przegrana z obu stron.")
}
else if(gracz_przegrana){
    print("Komputer wygrał.")
}
else if(komp_przegrana){
    print("Wygrałeś!")
}
else if(gracz_sum > komp_sum){
    print("Wygrałeś!")
}
else if(gracz_sum == komp_sum){
    print("Remis.")
}
else{
    print("Komputer wygrał.")
}

readLine()