import Text.Show.Functions

type Nombre = String
type Valor = Float
type Botin = [Tesoro]
type Saqueo = Tesoro -> Bool

data Tesoro = Tesoro {
    nombreTesoro :: Nombre,
    valorTesoro :: Valor
} deriving (Show)

data Pirata = Pirata {
    nombre :: Nombre,
    botin :: Botin,
    criterioSaqueo :: Saqueo
} deriving (Show)

-- 1)
valorSaqueoMayorA10 :: Saqueo
valorSaqueoMayorA10 = (>10) . valorTesoro

saqueoEspeficio :: Nombre -> Saqueo
saqueoEspeficio nombre tesoro = elem nombre $ words (nombreTesoro tesoro)

conCorazon :: Saqueo
conCorazon tesoro = False

pirataComplejo :: Tesoro -> [Saqueo] -> Bool
pirataComplejo tesoro criterio = any ($ tesoro) criterio

-- 2)
brujula :: Tesoro
brujula = Tesoro "Brujula" 10000

jarroDeArena :: Tesoro
jarroDeArena = Tesoro {
    nombreTesoro = "Jarro de Arena",
    valorTesoro = 0
}

cajitaMusical :: Tesoro
cajitaMusical = Tesoro "Cajita Musical" 1

sombrero :: Tesoro
sombrero = Tesoro "Sombrero de Capitan" 50

anillo :: Tesoro
anillo = Tesoro "Anillo" 500

jackSparrow :: Pirata
jackSparrow = Pirata {
    nombre = "Jack Sparrow",
    botin = [brujula, jarroDeArena],
    criterioSaqueo = flip pirataComplejo [valorSaqueoMayorA10, saqueoEspeficio "Sombrero"]
}

davidJones :: Pirata
davidJones = Pirata {
    nombre = "David Jones", 
    botin = [cajitaMusical],
    criterioSaqueo = conCorazon
}

-- 3)
type Isla = Botin
type Ciudad = [Ciudadano]
type Tripulacion = [Pirata]

data Ciudadano = Ciudadano {
    nombreCiudadano :: Nombre,
    joyas :: Botin
}

ron :: Tesoro
ron = Tesoro "Ron" 25

monedaDelMuerto :: Tesoro
monedaDelMuerto = Tesoro "Moneda del Muerto" 100

cuchillo :: Tesoro
cuchillo = Tesoro "Cuchillo" 5

perlaNegra :: Tripulacion
perlaNegra = [jackSparrow]

holandesErrante :: Tripulacion
holandesErrante = [davidJones]

islaDeRon :: Isla
islaDeRon = repeat ron

elizabethSwan :: Ciudadano
elizabethSwan = Ciudadano "Elizabeth Swan" [monedaDelMuerto]

willTurner :: Ciudadano
willTurner = Ciudadano "Will Turner" [cuchillo]

portRoyal :: Ciudad
portRoyal = [elizabethSwan, willTurner]

-- 4)
anclarEnIsla :: Isla -> Tripulacion -> Tripulacion
anclarEnIsla isla tripulacion
    | length isla == length tripulacion = zipWith sumarABotin tripulacion isla
    | otherwise = tripulacion

sumarABotin :: Pirata -> Tesoro -> Pirata
sumarABotin pirata tesoro = pirata { botin = tesoro : (botin pirata)}

-- 5)
saquearCiudad :: Ciudad -> Tripulacion -> Tripulacion
saquearCiudad ciudad tripulacion
    | length ciudad == length tripulacion = zipWith robarJoyas ciudad tripulacion
    | otherwise = tripulacion

robarJoyas :: Ciudadano -> Pirata -> Pirata
robarJoyas ciudadano pirata = foldl sumarABotin pirata (tesoroDeseados pirata ciudadano)

tesoroDeseados :: Pirata -> Ciudadano -> Botin
tesoroDeseados pirata ciudadano = filter (criterioSaqueo pirata) (joyas ciudadano)

-- 6)
hacersePirata :: Ciudadano -> Saqueo -> Pirata
hacersePirata ciudadano saqueo = Pirata {
    nombre = nombreCiudadano ciudadano, 
    botin = joyas ciudadano, 
    criterioSaqueo = saqueo
}

-- 7)
ataqueEntrePiratas :: Pirata -> Pirata -> Pirata
ataqueEntrePiratas atacante defensor = perdedorEncuentro atacante defensor

perdedorEncuentro :: Pirata -> Pirata -> Pirata
perdedorEncuentro atacante defensor
    | largoBarga atacante > largoBarga defensor = quedarseConBotin defensor
    | otherwise = defensor

largoBarga :: Pirata -> Valor
largoBarga pirata = sum $ map valorTesoro (botin pirata)

quedarseConBotin :: Pirata -> Pirata
quedarseConBotin perdedor = perdedor {botin = []}

-- 8)
choqueDeTripulaciones :: Tripulacion -> Tripulacion -> Tripulacion
choqueDeTripulaciones atacantes defensores = manoAMano atacantes (abandonenLaNave defensores)

manoAMano :: Tripulacion -> Tripulacion -> Tripulacion
manoAMano atacantes defensores
    | length atacantes == length defensores = zipWith ataqueEntrePiratas atacantes defensores
    | otherwise = defensores

abandonenLaNave :: Tripulacion -> Tripulacion
abandonenLaNave defensores = filter tienenBotin defensores

tienenBotin :: Pirata -> Bool
tienenBotin = (>0) . length . botin

-- 9)