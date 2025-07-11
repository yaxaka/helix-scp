-- Autorzy: zgredinzyyy (Poprawki + Brakujące rzeczy) || Veran120, Michał, Lechu2375 https://github.com/lechu2375/helix-polishlocalization/blob/master/sh_polish.lua

NAME = "Polski"

LANGUAGE = {
	helix = "Helix",

	introTextOne = "fist industries prezentuje",
	introTextTwo = "w współpracy z %s",
	introContinue = "wciśnij spację by kontynuować",

	helpIdle = "Wybierz kategorię",
	helpCommands = "Komendy z parametrami w <strzałkach> są wymagane, a w [nawiasach kwadratowych] są opcjonalne",
	helpFlags = "Flagi z zielonym tłem są dostępne przez tą postać.",

	creditSpecial = "Podziękowania dla",
	creditLeadDeveloper = "Główny Developer",
	creditUIDesigner = "UI Designer",
	creditManager = "Project Manager",
	creditTester = "Lead Tester",

	chatTyping = "Pisze...",
	chatTalking = "Mówi...",
	chatYelling = "Krzyczy...",
	chatWhispering = "Szepcze...",
	chatPerforming = "Wykonuje...",
	chatNewTab = "Nowa karta",
	chatReset = "Zresetuj pozycję",
	chatResetTabs = "Resetuj karty",
	chatCustomize = "Personalizuj...",
	chatCloseTab = "Zamknij kartę",
	chatTabName = "Nazwa karty",
	chatAllowedClasses = "Dostępne Klasy czatów",
	chatTabExists = "Karta z taką nazwą już instnieje!",
	chatMarkRead = "Odznacz wszystko jako przeczytane",

	community = "Community",
	checkAll = "Zaznacz wszystko",
	uncheckAll = "Odznacz wszystko",
	color = "Kolor",
	type = "Typ",
	display = "Wyświetlanie",
	loading = "Ładowanie",
	dbError = "Połączenie z bazą danych nie powiodło się",
	unknown = "Nieznane",
	noDesc = "Opis niedostępny",
	create = "Stwórz",
	update = "Zaktualizuj",
	load = "",
	loadTitle = "",
	leave = "Opuść serwer",
	leaveTip = "Opuść ten serwer.",
	["return"] = "Powrót",
	returnTip = "Powróć do poprzedniego menu.",
	proceed = "Kontynuuj",
	faction = "Frakcja",
	skills = "Umiejętności",
	choose = "Wybierz",
	chooseFaction = "Wybierz Frakcje",
	chooseDescription = "Zdefiniuj swoją postać",
	chooseSkills = "Dostosuj swoje umiejętności",
	name = "Imię i Nazwisko",
	description = "Opis",
	model = "Model",
	attributes = "Atrybuty",
	attribPointsLeft = "Pozostałe punkty",
	charInfo = "Informacje o postaci",
	charCreated = "Udało ci się stworzyć swoją postać.",
	charCreateTip = "Wypełnij pola poniżej i klinij 'Zakończ' aby stworzyć swoją postać.",
	invalid = "Podałeś niewłaściwe(ą) %s",
	nameMinLen = "Twoje imię musi zawierać conajmniej %d znaków!",
	nameMaxLen = "Twoje imię nie może posiadać więcej niż %d znaków!",
	descMinLen = "Twoje opis musi zawierać conajmniej %d znaków!",
	maxCharacters = "Nie możesz utworzyć więcej postaci!",
	player = "Gracz",
	finish = "Zakończ",
	finishTip = "Ukończ tworzenie postaci.",
	needModel = "Musisz wybrać poprawny model!",
	creating = "Twoja postać jest aktualnie tworzona...",
	unknownError = "Wystąpił nieznany błąd!",
	areYouSure = "jesteś pewien?",
	delete = "Usuń",
	deleteConfirm = "Ta postać będzie bezpowrotnie usunięta!",
	deleteComplete = "%s został(a) usunięty(a).",
	no = "Nie",
	yes = "Tak",
	close = "Zamknij",
	save = "Zapisz",
	itemInfo = "Imię Nazwisko: %s\nOpis: %s",
	itemCreated = "Przedmiot(y) pomyślnie utworzony.",
	cloud_no_repo = "Repozytorium, które zostało podane jest nieprawidłowe.",
	cloud_no_plugin = "Podany plugin jest nieprawidłowy.",
	inv = "Ekwipunek",
	plugins = "Pluginy",
	pluginLoaded = "%s włączył \"%s\" plugin na następne załadowanie mapy.",
	pluginUnloaded = "%s wyłączył \"%s\" plugin z następnego załadowania mapy.",
	loadedPlugins = "Załadowane Pluginy",
	unloadedPlugins = "Niezaładowane Pluginy",
	on = "On",
	off = "Off",
	author = "Autor",
	version = "Wersja",
	characters = "Postacie",
	business = "Biznes",
	settings = "Opcje",
	config = "Konfiguracja",
	chat = "Czat",
	appearance = "Wygląd",
	misc = "Różne",
	oocDelay = "Musisz poczekać %s sekund przed ponownym użyciem OOC.",
	loocDelay = "Musisz poczekać %s sekund przed ponownym użyciem LOOC.",
	usingChar = "Aktualnie używasz tej postaci.",
	notAllowed = "Przepraszamy, nie masz uprawnień do zrobienia tego.",
	itemNoExist = "Przedmiot o który prosiłeś nie istnieje.",
	cmdNoExist = "Taka komenda nie istnieje.",
	charNoExist = "Nie znaleziono pasującej postaci.",
	plyNoExist = "Nie znaleziono pasującego gracza.",
	cfgSet = "%s ustawił \"%s\" na %s.",
	drop = "Wyrzuć",
	dropTip = "Upuszcza ten przedmiot z twojego ekwipunku.",
	take = "Podnieś",
	takeTip = "Weź ten przedmiot i umieść go w swoim ekwipunku.",
	dTitle = "Drzwi do kupienia",
	dTitleOwned = "Wykupione Drzwi",
	dIsNotOwnable = "Tych drzwi nie można kupić.",
	dIsOwnable = "Możesz kupić te drzwi naciskając F2.",
	dMadeUnownable = "Uczyniłeś te drzwi niemożliwymi do kupienia.",
	dMadeOwnable = "Uczyniłeś te drzwi możliwymi do kupienia.",
	dNotAllowedToOwn = "Nie możesz kupić tych drzwi.",
	dSetDisabled = "Wyłączyłeś te drzwi z użytku.",
	dSetNotDisabled = "Ponownie można używać tych drzwi.",
	dSetHidden = "Schowałeś te drzwi.",
	dSetNotHidden = "Usunąłeś te drzwi z ukrytych.",
	dSetParentDoor = "Uczyniłeś te drzwi swoimi drzwiami nadrzędnymi.",
	dCanNotSetAsChild = "Nie możesz ustawi aby drzwi nadrzędne były drzwiami podrzędnymi.",
	dAddChildDoor = "You have added a this door as a child.",
	dRemoveChildren = "Usunąłeś wszystkie drzwi podrzędne należące do tych drzwi.",
	dRemoveChildDoor = "Te drzwi już nie są drzwiami podrzędnymi.",
	dNoParentDoor = "Nie masz ustawionych drzwi nadrzędnych.",
	dOwnedBy = "Te drzwi należą do %s.",
	dConfigName = "Drzwi",
	dSetFaction = "Te drzwi należą teraz do frakcji %s.",
	dRemoveFaction = "Te drzwi już nie należą do żadnej frakcji.",
	dNotValid = "Nie patrzysz na prawidłowe drzwi.",
	canNotAfford = "Nie stać Cię na kupienie tego.",
	dPurchased = "Kupiłeś te drzwi za %s.",
	dSold = "Sprzedałeś te drzwi za %s.",
	notOwner = "Nie jesteś właścicielem tego.",
	invalidArg = "Podałeś niepoprawną wartość dla argumentu #%s.",
	invalidFaction = "Frakcja, którą podałeś nie została znaleziona!",
	flagGive = "%s dał %s następujące flagi: '%s'.",
	flagGiveTitle = "Daj Flagi",
	flagTake = "%s zabrał od %s następujące flagi: '%s'.",
	flagTakeTitle = "Zabierz Flagi",
	flagNoMatch = "Musisz posiadać flagę(i) \"%s\" aby wykonać tą czynność.",
	panelAdded = "Dodałeś nowy panel.",
	panelRemoved = "Usunąłęś %d panel(e)",
	textAdded = "Dodałeś tekst.",
	textRemoved = "Usunąłeś %s tekst(y).",
	moneyTaken = "Znalazłeś %s.",
	moneyGiven = "Otrzymałeś %s.",
	insufficientMoney = "Nie posiadasz tyle środków!",
	businessPurchase = "Kupiłeś %s za %s.",
	businessSell = "Sprzedałeś %s za %s.",
	businessTooFast = "Zaczekaj przed następnym kupnem!",
	cChangeModel = "%s zmienił model gracza %s na %s.",
	cChangeName = "%s zmienił imię gracza %s na %s.",
	cChangeSkin = "%s zmienił model %s na %s.",
	cChangeGroups = "%s zmienił bodygroupy %s \"%s\" na %s.",
	cChangeFaction = "%s przeniósł %s do frakcji %s.",
	playerCharBelonging = "Ten przedmiot należy do innej postaci należącej do Ciebie.",
	spawnAdd = "Dodałeś punkt odradzania dla %s.",
	spawnDeleted = "Usunąłeś %s punkt(y) odradzania się.",
	someone = "Ktoś",
	rgnLookingAt = "Pozwól osobie na którą patrzysz, aby Cię rozpoznawała.",
	rgnWhisper = "Pozwól tym, którzy są w zasięgu Twoich szeptów, aby Cię rozpoznawali.",
	rgnTalk = "Pozwól tym, którzy są w zasięgu normalnych rozmów, aby Cię rozpoznawali.",
	rgnYell = "Pozwól tym, którzy są w zasięgu Twoich krzyków, aby Cię rozpoznawali.",
	icFormat = "%s mówi: \"%s\"",
	rollFormat = "%s wylosował %s.",
	wFormat = "%s szepcze: \"%s\"",
	yFormat = "%s krzyczy: \"%s\"",
	sbOptions = "Kliknij aby zobaczyć opcje dla %s.",
	spawnAdded = "Dodałeś punkt odradzania dla %s.",
	whitelist = "%s dodał %s na whitelistę frakcji %s.",
	unwhitelist = "%s usunął %s z whitelisty frakcji %s.",
	noWhitelist = "Nie masz dostępu do whitelisty na tą postać!",
	gettingUp = "Podnosisz się...",
	wakingUp = "Wraca Ci świadomość...",
	Weapons = "Broń",
	checkout = "Idź do kasy (%s)",
	purchase = "Kup",
	purchasing = "Kupuję...",
	success = "Sukces",
	buyFailed = "Zakupy nie powiodły się.",
	buyGood = "Zakupy udane!",
	shipment = "Dostawa",
	shipmentDesc = "Ta dostawa należy do %s.",
	class = "Klasa",
	classes = "Klasy",
	illegalAccess = "Nielegalny Dostęp.",
	becomeClassFail = "Nie udało Ci się zostać %s.",
	becomeClass = "Zostałeś %s.",
	setClass = "Ustawiłeś klasę %s na %s.",
	attributeSet = "Ustawiłeś %s %s na %s.",
	attributeNotFound = "You have specified an invalid attribute!",
	attributeUpdate = "Podwyższyłeś %s %s o %s.",
	noFit = "Nieposiadasz wystarczająco miejsca, aby zmieścić ten przedmiot!",
	itemOwned = "Nie możesz wchodzić w interakcje z przedmiotami, które posiadasz jako inna postać!",
	help = "Pomoc",
	commands = "Komendy",
	doorSettings = "Ustawienia Drzwi",
	sell = "Sprzedaj",
	access = "Dostęp",
	locking = "Blokowanie tego przedmiotu...",
	unlocking = "Odblokowywanie tego przedmiotu...",
	modelNoSeq = "Twój model nie obsługuje tej animacji.",
	notNow = "Nie możesz tego aktualnie zrobić.",
	faceWall = "Musisz patrzeć na ścianę aby to wykonać.",
	faceWallBack = "Musisz stać tyłem do ściany aby to wykonać.",
	descChanged = "Zmieniłeś rysopis swojej postaci.",
	noOwner = "Nieprawidłowy właściciel.",
	invalidItem = "Wskazałeś nieprawidłowy przedmiot!",
	invalidInventory = "Wskazałeś nieprawidłowy ekwipunek!",
	home = "Strona Główna",
	charKick = "%s wyrzucił %s.",
	charBan = "%s zablokował postać %s.",
	charBanned = "Ta postać jest zablokowana.",
	charBannedTemp = "Ta postać jest tymczasowo zablokowana.",
	playerConnected = "%s połączył się z serwerem.",
	playerDisconnected = "%s wyszedł z serwera.",
	setMoney = "Ustawiłeś ilość pieniędzy %s na %s.",
	itemPriceInfo = "Możesz kupić ten przedmiot za %s.\nMożesz sprzedać ten przedmiot za %s",
	free = "Darmowe",
	vendorNoSellItems = "Nie ma przedmiotów do sprzedania.",
	vendorNoBuyItems = "Nie ma przedmiotów do kupienia.",
	vendorSettings = "Ustawienia sprzedawców",
	vendorUseMoney = "Czy sprzedawcy powinni używać pieniędzy?",
	vendorNoBubble = "Ukryć dymek sprzedawcy?",
	mode = "Tryb",
	price = "Cena",
	stock = "Zasób",
	none = "Nic",
	vendorBoth = "Kupowanie i Sprzedawanie",
	vendorBuy = "Tylko kupowanie",
	vendorSell = "Tylko sprzedawanie",
	maxStock = "Maksymalny zasób",
	vendorFaction = "Edytor frakcji",
	buy = "Kup",
	vendorWelcome = "Witaj w moim sklepie, czy mogę Ci coś podać?",
	vendorBye = "Przyjdź niedługo z powrotem!",
	charSearching = "Aktualnie szukasz już innej postaci, proszę poczekać.",
	charUnBan = "%s odblokował postać %s.",
	charNotBanned = "Ta postać nie jest zablokowana.",
	quickSettings = "Szybkie Ustawienia",
	vmSet = "Ustawiłeś swoją pocztę głosową.",
	vmRem = "Usunąłęś swoją pocztę głosową.",
	noPerm = "Nie możesz tego zrobić!",
	youreDead = "Jesteś martwy",
	injMajor = "Widoczne krytyczne obrażenia.",
	injLittle = "Widoczne obrażenia.",
	chgName = "Zmień Imię i Nazwisko.",
	chgNameDesc = "Wprowadź nowę imię i nazwisko postaci poniżej.",
	weaponSlotFilled = "Nie możesz użyć kolejnej broni typu %s!",
	equippedBag = "Nie możesz przemieszczać torby z wyekwipowanym przedmiotem!",
	equippedWeapon = "Nie możesz przemieszczać aktualnie wyekwipowanej broni!",
	nestedBags = "Nie możesz wrzucić torby do torby!",
	outfitAlreadyEquipped = "Już nosisz ubranie tego typu!",
	useTip = "Używa przedmiotu.",
	equipTip = "Zakłada przedmiot.",
	unequipTip = "Zdejmuje przedmiot.",
	consumables = "Towary konsumpcyjne.",
	plyNotValid = "Nie patrzysz na prawidłowego gracza.",
	restricted = "Zostałeś związany.",
	salary = "Otrzymałeś wynagrodzenie w wysokości %s",
	noRecog = "Nie poznajesz tej osoby.",
	curTime = "Aktualny czas to %s.",
	vendorEditor = "Edytor Sprzedawcy",
	edit = "Edytuj",
	disable = "Wyłącz",
	vendorPriceReq = "Wprowadź nową cenę dla tego produktu.",
	vendorEditCurStock = "Edytuj aktualny zapas",
	vendorStockReq = "Wprowadź ile produktów powinno się znajdować maksymalnie w zasobie",
	vendorStockCurReq = "Wprowadź ile przedmiotów jest dostępnych do sprzedarzy z całego zasobu.",
	you = "Ty",
	vendorSellScale = "Skala ceny sprzedaży",
	vendorNoTrade = "Nie możesz dokonać wymiany z tym sprzedawcą!",
	vendorNoMoney = "Sprzedawce nie stać na ten przedmiot!",
	vendorNoStock = "Sprzedawca nie ma tego produktu aktualnie w asortymencie!",
	contentTitle = "Nie znaleziono zawartości dla trybu Helix",
	contentWarning = "Zawartość dla trybu Helix nie został wgrana. Rezultatem tego może być brak części funkcji.\nCzy chciałbyś otworzyć stronę warsztatu z daną zawartością?",
	flags = "Flagi",
	mapRestarting = "Restart mapy za %d sekund!",
	chooseTip = "Wybierz postać do gry.",
	deleteTip = "Usuń tą postać.",
	storageInUse = "Ktoś inny używa tego teraz!",
	storageSearching = "Przeszukiwanie...",
	container = "Pojemnik",
	containerPassword = "Ustawiłeś hasło tego pojemnika na %s.",
	containerPasswordRemove = "Usunąłeś hasło z tego pojemnika.",
	containerPasswordWrite = "Wprowadź hasło.",
	containerName = "Ustawiłeś nazwę tego pojemnika na %s.",
	containerNameWrite = "Wprowadź nazwę.",
	containerNameRemove = "Usunąłeś nazwę z tego pojemnika.",
	containerInvalid = "Musisz patrzeć na pojemnik, aby tego użyć!",
	wrongPassword = "Wprowadziłeś złe hasło!",
	respawning = "Odradzanie...",
	tellAdmin = "Powiadom administrację o tym błędzie: %s",

	mapAdd = "Dodałeś nową scenerie mapy.",
	mapDel = "Usunąłęś %d scenerie mapy.",
	mapRepeat = "Teraz dodaj punkt drugorzędny",

	scoreboard = "Tabela",
	ping = "Ping: %d",
	viewProfile = "Obejrzyj profil Steam.",
	copySteamID = "Skopiuj Steam ID",

	money = "Pieniądze",
	moneyLeft = "Twoje Pieniądze: ",
	currentMoney = "Obecna ilość pieniędzy: ",

	invalidClass = "To nie jest odpowiednia klasa!",
	invalidClassFaction = "To nie jest poprawna klasa dla tej frakcji!",

	miscellaneous = "Różne",
	general = "Generalne",
	observer = "Obserwator",
	performance = "Wydajnośc",
	thirdperson = "Trzecia osoba",
	date = "Data",
	interaction = "Interakcja",
	server = "Serwer",

	resetDefault = "Ustaw domyślnie",
	resetDefaultDescription = "To zresetuje \"%s\" do swojej domyślej wartości \"%s\".",
	optOpenBags = "Otwórz torbe z ekwipunkiem",
	optdOpenBags = "Automatycznie pokazuje wszystkie torby w twoim ekwipunku gdy menu jest otwarte.",
	optShowIntro = "Pokaż intro przy wchodzeniu na serwer",
	optdShowIntro = "Pokazuje wstęp do Helixa następnym razem gdy będziesz wchodzić. Ta opcja jest zawsze wyłączona po tym gdy obejrzałeś wstęp.",
	optCheapBlur = "Wyłącz rozmazanie",
	optdCheapBlur = "Zastępuje rozmazanie interfejsu z zwykłym przyciemnieniem.",
	optObserverTeleportBack = "Przywraca cię do poprzedniej lokalizacji",
	optdObserverTeleportBack = "Przywraca cię do lokalizacji w której włączyłeś tryb obserwatora.",
	optObserverESP = "Pokaż ESP administracyjne",
	optdObserverESP = "Pokazuje nazwę i lokalizację każdego gracza na serwerze.",
	opt24hourTime = "Używaj czasu 24-godzinnego",
	optd24hourTime = "Pokazuj znacznik czasu w formacie 24-godzinnym, zamiast 12-godzinnego (AM/PM).",
	optChatNotices = "Pokazuj uwagi/ogłoszenia na czacie",
	optdChatNotices = "Przenosi wszystkie uwagi/ogłoszenia wyskakujące w prawym górnym rogu do czatu.",
	optChatTimestamps = "Show timestamps in chat",
	optdChatTimestamps = "Pokazuje godzinę wysłania przy każdej wiadomości na czacie.",
	optAlwaysShowBars = "Zawsze pokazuj tabelkę z informacjami",
	optdAlwaysShowBars = "Tworzy tabelkę z informacjami w lewym górnym rogu, bez znaczenia czy ma być ukryte czy nie.",
	optAltLower = "Ukryj ręce gdy są opuszczone.",
	optdAltLower = "Ukrywa ręce, gdy są opuszczone.",
	optThirdpersonEnabled = "Włącz trzecią osobe",
	optdThirdpersonEnabled = "Przenosi kamerę za ciebie. Również może być włączone w konsoli za pomocą \"ix_togglethirdperson\" ",
	optThirdpersonClassic = "Włącz klasyczną trzecią osobe",
	optdThirdpersonClassic = "Moves your character's view with your mouse.",
	optThirdpersonVertical = "Wysokość kamery",
	optdThirdpersonVertical = "Jak wysoko powinna być kamera.",
	optThirdpersonHorizontal = "Wyrównanie kamery",
	optdThirdpersonHorizontal = "Jak bardzo na lewo lub prawo powinna być kamera.",
	optThirdpersonDistance = "Odległość kamery",
	optdThirdpersonDistance = "Jak oddalona powinna być kamera.",
	optThirdpersonCrouchOffset = "Kamera na wysokości kucania",
	optdThirdpersonCrouchOffset = "Jak wysoko powinna być kamera podczas kucania.",
	optDisableAnimations = "Wyłącz animacje",
	optdDisableAnimations = "Zatrzymuje animację by zapewnić natychmiastowe przejście.",
	optAnimationScale = "Skala animacji",
	optdAnimationScale = "Jak bardziej szybko lub długo powinny być animacje.",
	optLanguage = "Język",
	optdLanguage = "Język interfejsu.",
	optMinimalTooltips = "Minimalne powiadomienia z HUD'u",
	optdMinimalTooltips = "Changes the HUD tooltip style to take up less space.",
	optNoticeDuration = "Długość powiadomienia",
	optdNoticeDuration = "Jak długo powinny wyświetlać się uwagi/ogłoszenia (w sekundach).",
	optNoticeMax = "Maksimum powiadomień",
	optdNoticeMax = "Ilość powiadomień zanim nadmiar zostanie usunięty.",
	optChatFontScale = "Rozmiar czcionki",
	optdChatFontScale = "Skalowanie czcionki na czacie.",
	optChatOutline = "Obrysuj tekst w czacie",
	optdChatOutline = " Obramowuje tekst czatu. Włącz to, jeśli masz problemy z czytaniem czatu.",

	cmdRoll = "Losuje liczbę pomiędzy 0 a wyznaczoną liczbą.",
	cmdPM = "Wysyła prywatną wiadomośc do kogoś.",
	cmdReply = "Wysyła prywatną wiadomośc do ostatniej osoby, od której otrzymałeś wiadomość.",
	cmdSetVoicemail = "Ustawia lub usuwa automatyczną odpowiedź gdy ktoś wysyła ci prywatną wiadomość.",
	cmdCharGiveFlag = "Daje wyznaczoną flagę(i) do danej osoby.",
	cmdCharTakeFlag = "Usuwa wyznaczoną flagę(i) osobie jeśli ją ma.",
	cmdToggleRaise = "Podnosi albo opuscza broń, którą trzymasz.",
	cmdCharSetModel = "Ustawia model postaci.",
	cmdCharSetSkin = "Ustawia skórkę dla danej postaci.",
	cmdCharSetBodygroup = "Ustawia bodygroupy dla danego modelu.",
	cmdCharSetAttribute = "Ustawia poziom danego atrybutu dla osoby.",
	cmdCharAddAttribute = "Dodaje poziom do danego atrybutu.",
	cmdCharSetName = "Zmienia nazwę na wyznaczoną nazwę.",
	cmdCharGiveItem = "Daje wyznaczony przedmiot osobie.",
	cmdCharKick = "Zmusza osobę do wyjścia z jej postaci.",
	cmdCharBan = "Zabrania osobie wchodzenia na danej postaci.",
	cmdCharUnban = "Unban na zbanowaną postać.",
	cmdGiveMoney = "Daje wyznaczoną ilość pieniędzy osobie, na którą patrzysz",
	cmdCharSetMoney = "Zmienia ilośc pieniędzy do wyznaczonej ilośći.",
	cmdDropMoney = "Wyrzuca wyznaczoną ilość pieniędzy przed tobą.",
	cmdPlyWhitelist = "Pozwala osobie na stworzenie postaci w wyznaczonej frakcji.",
	cmdCharGetUp = "Sprróbuj wstać po upadku.",
	cmdPlyUnwhitelist = "Usuwa osobie whiteliste z danej frakcji.",
	cmdCharFallOver = "Walisz salto na plecy",
	cmdBecomeClass = "Zostań daną klasą w obecnej frakcji.",
	cmdCharDesc = "Ustaw opis zewnętrzny postaci.",
	cmdCharDescTitle = "Opis zewnętrzny",
	cmdCharDescDescription = "Napisz opis zewnętrzny twojej postaci.",
	cmdPlyTransfer = "Przenosi osobę do wyznaczonej frakcji.",
	cmdCharSetClass = "Zmusza osobę do zostania wyznaczoną klasą w obecnej frakcji.",
	cmdMapRestart = "Restartuje mape po wyznaczonej ilości czasu.",
	cmdPanelAdd = "Dodaje Web Panel.",
	cmdPanelRemove = "Usuwa Web Panel na który patrzysz.",
	cmdTextAdd = "Dodaje napis.",
	cmdTextRemove = "Usuwa napis na który patrzysz.",
	cmdMapSceneAdd = "Dodaje punkt widokowy widoczny w menu postaci.",
	cmdMapSceneRemove = "Usuwa punkt widokowy widoczny w menu postaci.",
	cmdSpawnAdd = "Dodaje punkt odrodzenia danej frakcji.",
	cmdSpawnRemove = "Usuwa punkt odrodzenia na który patrzysz.",
	cmdAct = "Wykonuje animację %s .",
	cmdContainerSetPassword = "Ustawia hasło kontenera na który patrzysz.",
	cmdDoorSell = "Sprzedaje drzwi na które patrzysz.",
	cmdDoorBuy = "Kupuje drzwi na które patrzysz.",
	cmdDoorSetUnownable = "Ustawia drzwi na które patrzysz na niemożliwe do posiadania.",
	cmdDoorSetOwnable = "Ustawia drzwi na które patrzysz na możliwe do posiadania.",
	cmdDoorSetFaction = "Ustawia drzwi na które patrzysz na posiadane przed daną frakcję.",
	cmdDoorSetDisabled = "Zabrania wykonywania komend na drzwi na które patrzysz.",
	cmdDoorSetTitle = "Ustawia opis drzwi na które patrzysz.",
	cmdDoorSetParent = "Ustawia właściciela danych drzwi.",
	cmdDoorSetChild = "Ustawia podwłaścicieli danych drzwi.",
	cmdDoorRemoveChild = "Usuwa podwłaściciela danych drzwi.",
	cmdDoorSetHidden = "Ukrywa opis drzwi na które patrzysz. Wciąż są możliwe do posiadania.",
	cmdDoorSetClass = "Ustawia drzwi na które patrzysz na posiadane przez daną klasę.",
	cmdMe = "Wykonaj akcję fizyczną.",
	cmdIt = "Wykonaj akcję twojego otoczenia.",
	cmdW = "Szeptaj.",
	cmdY = "Krzycz.",
	cmdEvent = "Wykonuje akcję, którą każdy widzi.",
	cmdOOC = "Wysyła wiadomość na czacie out-of-character.",
	cmdLOOC = "Wysyła wiadomość na lokalnym czacie out-of-character."
}
