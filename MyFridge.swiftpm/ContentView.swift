import SwiftUI
import Combine
import UserNotifications

// --- 1. LOCALIZATION (ระบบภาษา 11 ภาษา) ---
enum AppLanguage: String, CaseIterable, Identifiable {
    case en = "English"
    case th = "ไทย"
    case cn = "中文"
    case jp = "日本語"
    case kr = "한국어"
    case es = "Español"
    case fr = "Français"
    case de = "Deutsch"
    case ru = "Русский"
    case pt = "Português"
    case it = "Italiano"
    
    var id: String { self.rawValue }
}

// ✅ แก้ไข 1: ใส่ @MainActor แก้ปัญหา Concurrency (จากรูป Error สีฟ้า)
@MainActor
class LocalizationManager {
    static let shared = LocalizationManager()
    
    let translations: [String: [AppLanguage: String]] = [
        "login_title": [.en: "Welcome to My Fridge", .th: "ยินดีต้อนรับสู่ My Fridge", .cn: "欢迎来到我的冰箱", .jp: "My Fridgeへようこそ", .kr: "My Fridge에 오신 것을 환영합니다", .es: "Bienvenido a My Fridge", .fr: "Bienvenue sur My Fridge", .de: "Willkommen bei My Fridge", .ru: "Добро пожаловать", .pt: "Bem-vindo ao My Fridge", .it: "Benvenuto su My Fridge"],
        "enter_name": [.en: "Enter your name", .th: "กรอกชื่อของคุณ", .cn: "输入你的名字", .jp: "名前を入力", .kr: "이름을 입력하세요", .es: "Introduce tu nombre", .fr: "Entrez votre nom", .de: "Geben Sie Ihren Namen ein", .ru: "Введите ваше имя", .pt: "Digite seu nome", .it: "Inserisci il tuo nome"],
        "login_button": [.en: "Log In", .th: "เข้าสู่ระบบ", .cn: "登录", .jp: "ログイン", .kr: "로그인", .es: "Iniciar sesión", .fr: "Connexion", .de: "Anmelden", .ru: "Войти", .pt: "Entrar", .it: "Accedi"],
        "logout": [.en: "Log Out", .th: "ออกจากระบบ", .cn: "登出", .jp: "ログアウト", .kr: "로그아웃", .es: "Cerrar sesión", .fr: "Déconnexion", .de: "Abmelden", .ru: "Выйти", .pt: "Sair", .it: "Disconnettersi"],
        
        "app_name": [.en: "My Fridge", .th: "ตู้เย็นของฉัน", .cn: "我的冰箱", .jp: "マイ冷蔵庫", .kr: "나의 냉장고", .es: "Mi Nevera", .fr: "Mon Frigo", .de: "Mein Kühlschrank", .ru: "Мой Холодильник", .pt: "Minha Geladeira", .it: "Il Mio Frigo"],
        "reset_data": [.en: "Reset Data", .th: "รีเซ็ตข้อมูล", .cn: "重置数据", .jp: "リセット", .kr: "데이터 초기화", .es: "Restablecer datos", .fr: "Réinitialiser", .de: "Daten zurücksetzen", .ru: "Сброс данных", .pt: "Resetar dados", .it: "Resetta dati"],
        "random_pick": [.en: "Random Pick", .th: "สุ่มเมนู", .cn: "随机选择", .jp: "ランダム", .kr: "랜덤 선택", .es: "Elección aleatoria", .fr: "Au hasard", .de: "Zufallsauswahl", .ru: "Случайный выбор", .pt: "Escolha aleatória", .it: "Scelta casuale"],
        "add_item": [.en: "Add Item", .th: "เพิ่มของ", .cn: "添加物品", .jp: "追加", .kr: "항목 추가", .es: "Añadir artículo", .fr: "Ajouter un article", .de: "Artikel hinzufügen", .ru: "Добавить", .pt: "Adicionar item", .it: "Aggiungi"],
        
        "settings": [.en: "Settings", .th: "ตั้งค่า", .cn: "设置", .jp: "設定", .kr: "설정", .es: "Ajustes", .fr: "Paramètres", .de: "Einstellungen", .ru: "Настройки", .pt: "Configurações", .it: "Impostazioni"],
        "language": [.en: "Language", .th: "ภาษา", .cn: "语言", .jp: "言語", .kr: "언어", .es: "Idioma", .fr: "Langue", .de: "Sprache", .ru: "Язык", .pt: "Idioma", .it: "Lingua"],
        "display": [.en: "Display", .th: "การแสดงผล", .cn: "显示", .jp: "表示", .kr: "디스플레이", .es: "Pantalla", .fr: "Affichage", .de: "Anzeige", .ru: "Экран", .pt: "Tela", .it: "Display"],
        "notifications": [.en: "Notifications", .th: "การแจ้งเตือน", .cn: "通知", .jp: "通知", .kr: "알림", .es: "Notificaciones", .fr: "Notifications", .de: "Benachrichtigungen", .ru: "Уведомления", .pt: "Notificações", .it: "Notifiche"],
        "daily_reminder": [.en: "Daily Reminder", .th: "เตือนประจำวัน", .cn: "每日提醒", .jp: "毎日のリマインダー", .kr: "일일 알림", .es: "Recordatorio diario", .fr: "Rappel quotidien", .de: "Tägliche Erinnerung", .ru: "Ежедневное нап.", .pt: "Lembrete diário", .it: "Promemoria"],
        "theme_color": [.en: "Theme Color", .th: "สีธีม", .cn: "主题颜色", .jp: "テーマ色", .kr: "테마 색상", .es: "Color del tema", .fr: "Couleur du thème", .de: "Themenfarbe", .ru: "Цвет темы", .pt: "Cor do tema", .it: "Colore tema"],
        "about": [.en: "About", .th: "เกี่ยวกับ", .cn: "关于", .jp: "アプリについて", .kr: "정보", .es: "Acerca de", .fr: "À propos", .de: "Über", .ru: "О программе", .pt: "Sobre", .it: "Info"],
        
        "food_details": [.en: "Food Details", .th: "ข้อมูลอาหาร", .cn: "食物详情", .jp: "食品詳細", .kr: "음식 상세", .es: "Detalles de comida", .fr: "Détails", .de: "Lebensmitteldetails", .ru: "Детали еды", .pt: "Detalhes da comida", .it: "Dettagli cibo"],
        "food_name_placeholder": [.en: "Food Name", .th: "ชื่ออาหาร", .cn: "食物名称", .jp: "食品名", .kr: "음식 이름", .es: "Nombre", .fr: "Nom", .de: "Name", .ru: "Название", .pt: "Nome", .it: "Nome"],
        "type_emoji": [.en: "Type emoji", .th: "ใส่อิโมจิ", .cn: "输入表情", .jp: "絵文字を入力", .kr: "이모티콘 입력", .es: "Escribe un emoji", .fr: "Tapez un emoji", .de: "Emoji eingeben", .ru: "Введите эмодзи", .pt: "Digite um emoji", .it: "Scrivi emoji"],
        
        "category": [.en: "Category", .th: "หมวดหมู่", .cn: "类别", .jp: "カテゴリー", .kr: "카테고리", .es: "Categoría", .fr: "Catégorie", .de: "Kategorie", .ru: "Категория", .pt: "Categoria", .it: "Categoria"],
        "expires_in": [.en: "Expires in", .th: "หมดอายุใน", .cn: "过期时间", .jp: "有効期限", .kr: "유통기한", .es: "Vence en", .fr: "Expire dans", .de: "Läuft ab in", .ru: "Истекает через", .pt: "Vence em", .it: "Scade tra"],
        "icon_select": [.en: "Icon", .th: "ไอคอน", .cn: "图标", .jp: "アイコン", .kr: "아이콘", .es: "Icono", .fr: "Icône", .de: "Symbol", .ru: "Иконка", .pt: "Ícone", .it: "Icona"],
        "days_left": [.en: "days", .th: "วัน", .cn: "天", .jp: "日", .kr: "일", .es: "días", .fr: "jours", .de: "Tage", .ru: "дней", .pt: "dias", .it: "giorni"],
        "save": [.en: "Save", .th: "บันทึก", .cn: "保存", .jp: "保存", .kr: "저장", .es: "Guardar", .fr: "Enregistrer", .de: "Speichern", .ru: "Сохранить", .pt: "Salvar", .it: "Salva"],
        "cancel": [.en: "Cancel", .th: "ยกเลิก", .cn: "取消", .jp: "キャンセル", .kr: "취소", .es: "Cancelar", .fr: "Annuler", .de: "Abbrechen", .ru: "Отмена", .pt: "Cancelar", .it: "Annulla"],
        
        "empty_fridge": [.en: "Fridge is empty", .th: "ตู้เย็นโล่งจัง", .cn: "冰箱是空的", .jp: "冷蔵庫は空です", .kr: "냉장고가 비었어요", .es: "La nevera está vacía", .fr: "Le frigo est vide", .de: "Kühlschrank ist leer", .ru: "Холодильник пуст", .pt: "A geladeira está vazia", .it: "Frigo vuoto"],
        "eat": [.en: "Eat", .th: "กิน", .cn: "吃掉", .jp: "食べる", .kr: "먹기", .es: "Comer", .fr: "Manger", .de: "Essen", .ru: "Съесть", .pt: "Comer", .it: "Mangia"],
        "trash": [.en: "Trash", .th: "ทิ้ง", .cn: "丢弃", .jp: "捨てる", .kr: "버리기", .es: "Basura", .fr: "Jeter", .de: "Müll", .ru: "Мусор", .pt: "Lixo", .it: "Cestino"],
        "expired": [.en: "Expired", .th: "หมดอายุ", .cn: "已过期", .jp: "期限切れ", .kr: "만료됨", .es: "Vencido", .fr: "Expiré", .de: "Abgelaufen", .ru: "Истек", .pt: "Vencido", .it: "Scaduto"],
        "today": [.en: "Today!", .th: "วันนี้!", .cn: "今天!", .jp: "今日!", .kr: "오늘!", .es: "¡Hoy!", .fr: "Aujourd'hui !", .de: "Heute!", .ru: "Сегодня!", .pt: "Hoje!", .it: "Oggi!"],
        
        "recommended": [.en: "Recommended", .th: "เมนูแนะนำ", .cn: "推荐", .jp: "おすすめ", .kr: "추천", .es: "Recomendado", .fr: "Recommandé", .de: "Empfohlen", .ru: "Рекомендуем", .pt: "Recomendado", .it: "Consigliato"],
        "eat_before": [.en: "Eat before it expires in", .th: "รีบกินก่อนหมดอายุใน", .cn: "请在过期前食用", .jp: "期限切れ前に食べる", .kr: "만료되기 전에 드세요", .es: "Comer antes de", .fr: "Manger avant", .de: "Essen bevor", .ru: "Съесть до", .pt: "Comer antes de", .it: "Mangia prima di"],
        "okay_eat": [.en: "Okay, I'll eat this!", .th: "ตกลง กินอันนี้แหละ!", .cn: "好的，我吃这个！", .jp: "これにします！", .kr: "좋아요, 이걸로 할게요!", .es: "¡Vale, comeré esto!", .fr: "OK, je mange ça !", .de: "Okay, ich esse das!", .ru: "Ок, съем это!", .pt: "Ok, vou comer!", .it: "Ok, mangio questo!"],
        "close": [.en: "Close", .th: "ปิด", .cn: "关闭", .jp: "閉じる", .kr: "닫기", .es: "Cerrar", .fr: "Fermer", .de: "Schließen", .ru: "Закрыть", .pt: "Fechar", .it: "Chiudi"],
        
        "next": [.en: "Next", .th: "ถัดไป", .cn: "下一步", .jp: "次へ", .kr: "다음", .es: "Siguiente", .fr: "Suivant", .de: "Weiter", .ru: "Далее", .pt: "Próximo", .it: "Avanti"],
        "start": [.en: "Start", .th: "เริ่มต้น", .cn: "开始", .jp: "スタート", .kr: "시작", .es: "Empezar", .fr: "Commencer", .de: "Starten", .ru: "Начать", .pt: "Começar", .it: "Inizia"],
        
        // Settings Options
        "System": [.en: "System", .th: "ตามระบบ", .cn: "系统", .jp: "システム", .kr: "시스템", .es: "Sistema", .fr: "Système", .de: "System", .ru: "Система", .pt: "Sistema", .it: "Sistema"],
        "Light": [.en: "Light ☀️", .th: "โหมดสว่าง ☀️", .cn: "浅色 ☀️", .jp: "ライト ☀️", .kr: "라이트 ☀️", .es: "Claro ☀️", .fr: "Clair ☀️", .de: "Hell ☀️", .ru: "Светлая ☀️", .pt: "Claro ☀️", .it: "Chiaro ☀️"],
        "Dark": [.en: "Dark 🌙", .th: "โหมดมืด 🌙", .cn: "深色 🌙", .jp: "ダーク 🌙", .kr: "다크 🌙", .es: "Oscuro 🌙", .fr: "Sombre 🌙", .de: "Dunkel 🌙", .ru: "Темная 🌙", .pt: "Escuro 🌙", .it: "Scuro 🌙"],
        
        "Blue": [.en: "Blue", .th: "ฟ้า", .cn: "蓝色", .jp: "青", .kr: "파랑", .es: "Azul", .fr: "Bleu", .de: "Blau", .ru: "Синий", .pt: "Azul", .it: "Blu"],
        "Pink": [.en: "Pink", .th: "ชมพู", .cn: "粉色", .jp: "ピンク", .kr: "분홍", .es: "Rosa", .fr: "Rose", .de: "Rosa", .ru: "Розовый", .pt: "Rosa", .it: "Rosa"],
        "Orange": [.en: "Orange", .th: "ส้ม", .cn: "橙色", .jp: "オレンジ", .kr: "주황", .es: "Naranja", .fr: "Orange", .de: "Orange", .ru: "Оранжевый", .pt: "Laranja", .it: "Arancione"],
        "Purple": [.en: "Purple", .th: "ม่วง", .cn: "紫色", .jp: "紫", .kr: "보라", .es: "Púrpura", .fr: "Violet", .de: "Lila", .ru: "Фиолетовый", .pt: "Roxo", .it: "Viola"],
        "Green": [.en: "Green", .th: "เขียว", .cn: "绿色", .jp: "緑", .kr: "초록", .es: "Verde", .fr: "Vert", .de: "Grün", .ru: "Зеленый", .pt: "Verde", .it: "Verde"],
        "Black": [.en: "Black", .th: "ดำ", .cn: "黑色", .jp: "黒", .kr: "검정", .es: "Negro", .fr: "Noir", .de: "Schwarz", .ru: "Черный", .pt: "Preto", .it: "Nero"],
        
        // Categories
        "Meat": [.en: "Meat", .th: "เนื้อสัตว์", .cn: "肉类", .jp: "肉類", .kr: "고기", .es: "Carne", .fr: "Viande", .de: "Fleisch", .ru: "Мясо", .pt: "Carne", .it: "Carne"],
        "Fruit/Veg": [.en: "Fruit/Veg", .th: "ผัก/ผลไม้", .cn: "果蔬", .jp: "青果", .kr: "과일/채소", .es: "Fruta/Verdura", .fr: "Fruits/Légumes", .de: "Obst/Gemüse", .ru: "Фрукты/Овощи", .pt: "Frutas/Legumes", .it: "Frutta/Verdura"],
        "Drink": [.en: "Drink", .th: "เครื่องดื่ม", .cn: "饮料", .jp: "飲み物", .kr: "음료", .es: "Bebida", .fr: "Boisson", .de: "Getränk", .ru: "Напитки", .pt: "Bebida", .it: "Bevanda"],
        "Dairy": [.en: "Dairy", .th: "นม/เนย", .cn: "乳制品", .jp: "乳製品", .kr: "유제품", .es: "Lácteos", .fr: "Produits laitiers", .de: "Milchprodukte", .ru: "Молочные", .pt: "Laticínios", .it: "Latticini"],
        "Snack": [.en: "Snack", .th: "ขนม", .cn: "零食", .jp: "スナック", .kr: "간식", .es: "Snack", .fr: "Grignotage", .de: "Snack", .ru: "Закуски", .pt: "Lanche", .it: "Snack"],
        "Ingredient": [.en: "Ingredient", .th: "วัตถุดิบ", .cn: "配料", .jp: "食材", .kr: "재료", .es: "Ingrediente", .fr: "Ingrédient", .de: "Zutat", .ru: "Ингредиент", .pt: "Ingrediente", .it: "Ingrediente"],
        "General": [.en: "General", .th: "ทั่วไป", .cn: "其他", .jp: "その他", .kr: "일반", .es: "General", .fr: "Général", .de: "Allgemein", .ru: "Общее", .pt: "Geral", .it: "Generale"],
        
        // Onboarding
        "ob_title1": [.en: "Stop Food Waste", .th: "หยุดการทิ้งอาหาร", .cn: "停止浪费食物", .jp: "食品ロスをなくそう", .kr: "음식물 쓰레기 줄이기", .es: "Detén el desperdicio", .fr: "Arrêtez le gaspillage", .de: "Stoppt Lebensmittelverschwendung", .ru: "Остановите трату еды", .pt: "Pare o desperdício", .it: "Stop allo spreco"],
        "ob_desc1": [.en: "Save money and the planet.", .th: "ประหยัดเงินและรักษ์โลก", .cn: "省钱又环保", .jp: "お金と地球を守ろう", .kr: "돈과 지구를 지키세요.", .es: "Ahorra dinero y el planeta.", .fr: "Économisez de l'argent et la planète.", .de: "Sparen Sie Geld und den Planeten.", .ru: "Берегите деньги и планету.", .pt: "Economize dinheiro e o planeta.", .it: "Risparmia denaro e il pianeta."],
        "ob_title2": [.en: "Expiry Alerts", .th: "เตือนวันหมดอายุ", .cn: "过期提醒", .jp: "期限切れアラート", .kr: "만료 알림", .es: "Alertas de caducidad", .fr: "Alertes d'expiration", .de: "Ablaufwarnungen", .ru: "Оповещения о сроках", .pt: "Alertas de validade", .it: "Avvisi scadenza"],
        "ob_desc2": [.en: "Track expiration dates.", .th: "ติดตามวันหมดอายุได้ง่ายๆ", .cn: "轻松跟踪日期", .jp: "賞味期限を管理", .kr: "유통기한을 쉽게 추적하세요.", .es: "Rastrea fechas de caducidad.", .fr: "Suivez les dates d'expiration.", .de: "Verfallsdaten verfolgen.", .ru: "Отслеживайте сроки годности.", .pt: "Rastreie as datas de validade.", .it: "Traccia le scadenze."],
        "ob_title3": [.en: "What to eat?", .th: "กินอะไรดี?", .cn: "吃什么？", .jp: "何を食べよう？", .kr: "무엇을 먹을까요?", .es: "¿Qué comer?", .fr: "Quoi manger ?", .de: "Was essen?", .ru: "Что поесть?", .pt: "O que comer?", .it: "Cosa mangiare?"],
        "ob_desc3": [.en: "Let the app decide!", .th: "ให้แอปช่วยเลือกสิ!", .cn: "让应用决定！", .jp: "アプリに決めてもらおう！", .kr: "앱이 결정하게 하세요!", .es: "¡Deja que la app decida!", .fr: "Laissez l'application décider !", .de: "Lass die App entscheiden!", .ru: "Пусть приложение решит!", .pt: "Deixe o app decidir!", .it: "Lascia decidere all'app!"]
    ]
    
    func txt(_ key: String, lang: String) -> String {
        let selectedLang = AppLanguage(rawValue: lang) ?? .en
        return translations[key]?[selectedLang] ?? translations[key]?[.en] ?? key
    }
}

// --- 2. DATA MODEL & PERSISTENCE ---
struct FoodItem: Identifiable, Equatable, Codable {
    let id: UUID
    let name: String
    let category: String
    let daysRemaining: Int
    let emoji: String
    var isConsumed: Bool
    
    init(id: UUID = UUID(), name: String, category: String, daysRemaining: Int, emoji: String, isConsumed: Bool = false) {
        self.id = id
        self.name = name
        self.category = category
        self.daysRemaining = daysRemaining
        self.emoji = emoji
        self.isConsumed = isConsumed
    }
}

// --- 3. NOTIFICATION MANAGER ---
@MainActor
class NotificationManager {
    static let shared = NotificationManager()
    
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { _, _ in }
    }
    
    func scheduleDailyReminder(at date: Date, isEnabled: Bool) {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        guard isEnabled else { return }
        
        let content = UNMutableNotificationContent()
        content.title = "Time to check your fridge! 🧊"
        content.body = "Don't let food go to waste."
        content.sound = .default
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(identifier: "dailyReminder", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}

// --- 4. VIEW MODEL ---
@MainActor
class FridgeViewModel: ObservableObject {
    @Published var items: [FoodItem] = []
    @Published var suggestedItem: FoodItem?
    @Published var showSuggestionPopup: Bool = false
    
    private let saveKey = "SavedFoodItems"
    
    init() {
        loadData()
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decodedItems = try? JSONDecoder().decode([FoodItem].self, from: data) {
                self.items = decodedItems
                return
            }
        }
        self.items = []
    }
    
    func saveData() {
        if let encoded = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    func loadMockData() {
            let mockItems: [FoodItem] = [
                // 🥩 เนื้อสัตว์ (Meat)
                FoodItem(name: "Salmon", category: "Meat", daysRemaining: 1, emoji: "🐟"),
                FoodItem(name: "Beef Steak", category: "Meat", daysRemaining: 3, emoji: "🥩"),
                FoodItem(name: "Chicken", category: "Meat", daysRemaining: 2, emoji: "🍗"),
                FoodItem(name: "Bacon", category: "Meat", daysRemaining: 14, emoji: "🥓"),
                
                // 🥦 ผัก/ผลไม้ (Fruit/Veg)
                FoodItem(name: "Avocado", category: "Fruit/Veg", daysRemaining: 3, emoji: "🥑"),
                FoodItem(name: "Apple", category: "Fruit/Veg", daysRemaining: 7, emoji: "🍎"),
                FoodItem(name: "Banana", category: "Fruit/Veg", daysRemaining: 4, emoji: "🍌"),
                FoodItem(name: "Carrot", category: "Fruit/Veg", daysRemaining: 10, emoji: "🥕"),
                FoodItem(name: "Broccoli", category: "Fruit/Veg", daysRemaining: 5, emoji: "🥦"),
                FoodItem(name: "Tomato", category: "Fruit/Veg", daysRemaining: 6, emoji: "🍅"),
                
                // 🥤 เครื่องดื่ม (Drink)
                FoodItem(name: "Milk", category: "Drink", daysRemaining: 0, emoji: "🥛"),
                FoodItem(name: "Orange Juice", category: "Drink", daysRemaining: 12, emoji: "🧃"),
                FoodItem(name: "Water", category: "Drink", daysRemaining: 365, emoji: "💧"),
                FoodItem(name: "Soda", category: "Drink", daysRemaining: 30, emoji: "🥤"),
                
                // 🧀 นม/เนย (Dairy)
                FoodItem(name: "Cheese", category: "Dairy", daysRemaining: 15, emoji: "🧀"),
                FoodItem(name: "Yogurt", category: "Dairy", daysRemaining: 7, emoji: "🍦"),
                FoodItem(name: "Butter", category: "Dairy", daysRemaining: 60, emoji: "🧈"),
                
                // 🍳 วัตถุดิบ & อื่นๆ (Ingredient & General)
                FoodItem(name: "Eggs", category: "Ingredient", daysRemaining: 7, emoji: "🥚"),
                FoodItem(name: "Rice", category: "Ingredient", daysRemaining: 90, emoji: "🍚"),
                FoodItem(name: "Bread", category: "General", daysRemaining: 4, emoji: "🍞"),
                
                // 🍰 ขนม (Snack)
                FoodItem(name: "Orange Cake", category: "Snack", daysRemaining: -1, emoji: "🍰"), // หมดอายุแล้ว
                FoodItem(name: "Chocolate", category: "Snack", daysRemaining: 180, emoji: "🍫"),
                FoodItem(name: "Cookie", category: "Snack", daysRemaining: 25, emoji: "🍪")
            ]
            
            // เรียงลำดับตามวันหมดอายุ (น้อยไปมาก)
            self.items = mockItems.sorted { $0.daysRemaining < $1.daysRemaining }
            saveData()
        }
    
    func addItem(name: String, category: String, days: Int, emoji: String) {
        let newItem = FoodItem(name: name, category: category, daysRemaining: days, emoji: emoji)
        items.append(newItem)
        items.sort { $0.daysRemaining < $1.daysRemaining }
        saveData()
    }
    
    func removeItem(id: UUID) {
        if let index = items.firstIndex(where: { $0.id == id }) {
            showSuggestionPopup = false
            withAnimation(.spring()) { items[index].isConsumed = true }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation {
                    self.items.removeAll { $0.id == id }
                    self.saveData()
                }
            }
        }
    }
    
    func pickRandomItem() {
        let edibleItems = items.filter { !$0.isConsumed && $0.daysRemaining >= 0 }
        suggestedItem = edibleItems.randomElement()
        withAnimation(.spring()) { showSuggestionPopup = true }
    }
    
    var urgentCount: Int {
        items.filter { $0.daysRemaining <= 2 && $0.daysRemaining >= 0 }.count
    }
}

// --- 5. THEME MANAGER ---
struct ThemeManager {
    static func getColor(for theme: String) -> Color {
        switch theme {
        case "Pink": return .pink
        case "Orange": return .orange
        case "Purple": return .purple
        case "Green": return .green
        case "Black": return .black
        default: return .blue
        }
    }
}

// --- 6. MAIN CONTENT VIEW ---
struct ContentView: View {
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @AppStorage("appearance") var appearance = "System"
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding: Bool = false
    
    @StateObject var viewModel = FridgeViewModel()
    @State private var showAddSheet = false
    
    var selectedColorScheme: ColorScheme? {
        switch appearance {
        case "Light": return .light
        case "Dark": return .dark
        default: return nil
        }
    }
    
    var body: some View {
        ZStack {
            if !isLoggedIn {
                LoginView()
                    .transition(.opacity)
            } else if !hasSeenOnboarding {
                OnboardingView(hasSeenOnboarding: $hasSeenOnboarding)
                    .transition(.opacity)
            } else {
                MainAppView(viewModel: viewModel, showAddSheet: $showAddSheet)
                    .transition(.move(edge: .trailing))
            }
        }
        .animation(.easeInOut, value: isLoggedIn)
        .animation(.easeInOut, value: hasSeenOnboarding)
        .preferredColorScheme(selectedColorScheme)
    }
}

// --- 7. LOGIN VIEW ---
struct LoginView: View {
    @AppStorage("username") var username: String = ""
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @AppStorage("language") var language = "English"
    @AppStorage("appTheme") var appTheme = "Blue"
    
    @State private var inputName = ""
    @FocusState private var isFocused: Bool
    
    var body: some View {
        ZStack {
            ThemeManager.getColor(for: appTheme).opacity(0.1).ignoresSafeArea()
                .onTapGesture { isFocused = false }
            
            VStack(spacing: 30) {
                Spacer()
                Text("🧊").font(.system(size: 100)).shadow(radius: 10)
                Text(LocalizationManager.shared.txt("login_title", lang: language))
                    .font(.largeTitle).fontWeight(.bold).multilineTextAlignment(.center)
                
                VStack(spacing: 15) {
                    TextField(LocalizationManager.shared.txt("enter_name", lang: language), text: $inputName)
                        .focused($isFocused)
                        .submitLabel(.done)
                        .padding()
                        .background(Color(UIColor.secondarySystemGroupedBackground))
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.05), radius: 5)
                        .padding(.horizontal, 40)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { isFocused = true }
                        }
                    
                    Button(action: {
                        if !inputName.isEmpty {
                            username = inputName
                            withAnimation { isLoggedIn = true }
                        }
                    }) {
                        Text(LocalizationManager.shared.txt("login_button", lang: language))
                            .font(.headline).foregroundColor(.white).frame(maxWidth: .infinity).padding().background(inputName.isEmpty ? Color.gray : ThemeManager.getColor(for: appTheme)).cornerRadius(12).shadow(radius: 5)
                    }.disabled(inputName.isEmpty).padding(.horizontal, 40)
                }
                Spacer()
                Picker("Language", selection: $language) {
                    ForEach(AppLanguage.allCases) { lang in Text(lang.rawValue).tag(lang.rawValue) }
                }.pickerStyle(MenuPickerStyle()).padding(.bottom, 20)
            }
        }
    }
}

// --- 8. SETTINGS VIEW ---
struct SettingsView: View {
    @Binding var isPresented: Bool
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = true
    @AppStorage("notificationsEnabled") private var notificationsEnabled = false
    
    // ✅ แก้ไข 2: ใช้ Double แทน Date แก้ปัญหา iOS 18 (จากรูป Error สีแดง)
    @AppStorage("notificationTimeInterval") private var notificationTimeInterval: Double = Date().timeIntervalSince1970
    
    @AppStorage("appTheme") private var appTheme = "Blue"
    @AppStorage("appearance") private var appearance = "System"
    @AppStorage("language") private var language = "English"
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text(txt("display"))) {
                    Picker(txt("language"), selection: $language) {
                        ForEach(AppLanguage.allCases) { lang in Text(lang.rawValue).tag(lang.rawValue) }
                    }
                    Picker("Mode", selection: $appearance) {
                        Text(txt("System")).tag("System")
                        Text(txt("Light")).tag("Light")
                        Text(txt("Dark")).tag("Dark")
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text(txt("notifications"))) {
                    Toggle(txt("daily_reminder"), isOn: $notificationsEnabled)
                        .onChange(of: notificationsEnabled) { newValue in
                            if newValue { NotificationManager.shared.requestPermission() }
                            let date = Date(timeIntervalSince1970: notificationTimeInterval)
                            NotificationManager.shared.scheduleDailyReminder(at: date, isEnabled: newValue)
                        }
                    if notificationsEnabled {
                        DatePicker("Time", selection: Binding(
                            get: { Date(timeIntervalSince1970: notificationTimeInterval) },
                            set: { newDate in
                                notificationTimeInterval = newDate.timeIntervalSince1970
                                NotificationManager.shared.scheduleDailyReminder(at: newDate, isEnabled: notificationsEnabled)
                            }
                        ), displayedComponents: .hourAndMinute)
                    }
                }
                
                Section(header: Text(txt("theme_color"))) {
                    Picker("Color", selection: $appTheme) {
                        Text(txt("Blue")).tag("Blue")
                        Text(txt("Pink")).tag("Pink")
                        Text(txt("Orange")).tag("Orange")
                        Text(txt("Purple")).tag("Purple")
                        Text(txt("Green")).tag("Green")
                        Text(txt("Black")).tag("Black")
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section {
                    Button(action: { isLoggedIn = false; isPresented = false }) {
                        Text(txt("logout")).foregroundColor(.red)
                    }
                }
                
                Section(header: Text(txt("about"))) {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("2.0.0 Pro").foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle(txt("settings"))
            .navigationBarItems(trailing: Button(txt("close")) { isPresented = false })
        }
    }
    func txt(_ key: String) -> String { return LocalizationManager.shared.txt(key, lang: language) }
}

// --- 9. ONBOARDING ---
struct OnboardingView: View {
    @Binding var hasSeenOnboarding: Bool
    @State private var currentPage = 0
    @AppStorage("language") var language = "English"
    
    var body: some View {
        ZStack {
            Color(UIColor.systemBackground).ignoresSafeArea()
            VStack {
                TabView(selection: $currentPage) {
                    OnboardingPage(imageName: "trash.slash.fill", title: txt("ob_title1"), description: txt("ob_desc1"), color: .red).tag(0)
                    OnboardingPage(imageName: "clock.badge.exclamationmark.fill", title: txt("ob_title2"), description: txt("ob_desc2"), color: .orange).tag(1)
                    OnboardingPage(imageName: "dice.fill", title: txt("ob_title3"), description: txt("ob_desc3"), color: .blue).tag(2)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                
                HStack {
                    if currentPage > 0 {
                        Button(action: { withAnimation { currentPage -= 1 } }) {
                            Image(systemName: "arrow.left").font(.title2).foregroundColor(.gray).padding()
                        }
                    } else { Spacer().frame(width: 50) }
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation {
                            if currentPage < 2 { currentPage += 1 } else { hasSeenOnboarding = true }
                        }
                    }) {
                        HStack {
                            Text(currentPage == 2 ? txt("start") : txt("next")).fontWeight(.bold)
                            Image(systemName: currentPage == 2 ? "checkmark" : "arrow.right")
                        }
                        .foregroundColor(.white).padding(.vertical, 12).padding(.horizontal, 25)
                        .background(Capsule().fill(currentPage == 2 ? Color.green : Color.blue).shadow(radius: 5))
                    }
                }
                .padding(.horizontal, 30).padding(.bottom, 50)
            }
        }
    }
    func txt(_ key: String) -> String { return LocalizationManager.shared.txt(key, lang: language) }
}

struct OnboardingPage: View {
    let imageName: String, title: String, description: String, color: Color
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: imageName).font(.system(size: 100)).foregroundColor(color).padding()
            Text(title).font(.largeTitle).fontWeight(.bold).multilineTextAlignment(.center)
            Text(description).multilineTextAlignment(.center).padding(.horizontal)
        }
    }
}

// --- 10. MAIN APP VIEW ---
struct MainAppView: View {
    @ObservedObject var viewModel: FridgeViewModel
    @Binding var showAddSheet: Bool
    @State private var showSettings = false
    @AppStorage("appTheme") private var appTheme = "Blue"
    @AppStorage("username") var username: String = "User"
    @AppStorage("language") var language = "English"
    
    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground).ignoresSafeArea()
            VStack(spacing: 0) {
                DashboardHeader(username: username, urgentCount: viewModel.urgentCount, themeColor: ThemeManager.getColor(for: appTheme), onSettingsTap: { showSettings = true })
                    .padding(.bottom, 20)
                
                if viewModel.items.isEmpty {
                    Spacer()
                    VStack(spacing: 10) {
                        Text(txt("empty_fridge")).font(.title2).bold().foregroundColor(.gray)
                        Button(action: { viewModel.loadMockData() }) {
                            Text(txt("reset_data")).foregroundColor(.blue)
                        }
                    }
                    Spacer()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(viewModel.items) { item in
                                if !item.isConsumed {
                                    FoodCard(item: item) { viewModel.removeItem(id: item.id) }
                                        .transition(.scale.combined(with: .opacity))
                                }
                            }
                        }
                        .padding(.horizontal).padding(.bottom, 120)
                    }
                }
            }
            
            VStack {
                Spacer()
                HStack(spacing: 15) {
                    Spacer()
                    FloatingButton(icon: "dice.fill", color: .orange, size: 50.0, label: txt("random_pick")) { viewModel.pickRandomItem() }
                    FloatingButton(icon: "plus", color: ThemeManager.getColor(for: appTheme), size: 65.0, label: txt("add_item")) { showAddSheet = true }
                }
                .padding()
            }
            
            if viewModel.showSuggestionPopup {
                Color.black.opacity(0.4).ignoresSafeArea().onTapGesture { withAnimation { viewModel.showSuggestionPopup = false } }
                SuggestionPopup(item: viewModel.suggestedItem, themeColor: ThemeManager.getColor(for: appTheme), onConfirm: {
                    if let item = viewModel.suggestedItem { viewModel.removeItem(id: item.id) }
                }, onClose: { withAnimation { viewModel.showSuggestionPopup = false } })
                .frame(maxWidth: 400).zIndex(1).transition(.scale)
            }
        }
        .sheet(isPresented: $showAddSheet) {
            AddItemView { name, category, days, emoji in
                viewModel.addItem(name: name, category: category, days: days, emoji: emoji)
            }
        }
        .sheet(isPresented: $showSettings) { SettingsView(isPresented: $showSettings) }
    }
    func txt(_ key: String) -> String { return LocalizationManager.shared.txt(key, lang: language) }
}

struct AddItemView: View {
    @Environment(\.presentationMode) var presentationMode
    var onAdd: (String, String, Int, String) -> Void
    @State private var name = ""
    @State private var category = "General"
    @State private var days = 3
    @State private var emoji = "📦"
    @AppStorage("language") var language = "English"
    
    let emojis = ["🥩","🥦","🥛","🧀","🥚","🍰","🥤","🍎","🌶️","🍞"]
    let categories = ["Meat", "Fruit/Veg", "Drink", "Dairy", "Snack", "Ingredient", "General"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text(txt("food_details"))) { TextField(txt("food_name_placeholder"), text: $name) }
                Section(header: Text(txt("category"))) {
                    Picker(txt("category"), selection: $category) {
                        ForEach(categories, id: \.self) { cat in
                            Text(txt(cat)).tag(cat)
                        }
                    }
                }
                Section(header: Text(txt("expires_in"))) {
                    Stepper(value: $days, in: -1...365) {
                        HStack { Text("\(days)").bold().foregroundColor(days <= 2 ? .orange : .primary); Text(txt("days_left")) }
                    }
                }
                Section(header: Text(txt("icon_select"))) {
                    TextField(txt("type_emoji"), text: $emoji)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack { ForEach(emojis, id: \.self) { e in Button(action: { emoji = e }) { Text(e).font(.largeTitle).padding(5).background(emoji == e ? Color.blue.opacity(0.2) : Color.clear).cornerRadius(8) } } }
                    }
                }
            }
            .navigationTitle(txt("add_item"))
            .navigationBarItems(
                leading: Button(txt("cancel")) { presentationMode.wrappedValue.dismiss() },
                trailing: Button(txt("save")) { onAdd(name, category, days, emoji); presentationMode.wrappedValue.dismiss() }.disabled(name.isEmpty)
            )
        }
    }
    func txt(_ key: String) -> String { return LocalizationManager.shared.txt(key, lang: language) }
}

struct DashboardHeader: View {
    let username: String, urgentCount: Int, themeColor: Color
    var onSettingsTap: () -> Void
    @AppStorage("language") var language = "English"
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30).fill(LinearGradient(gradient: Gradient(colors: [themeColor, themeColor.opacity(0.7)]), startPoint: .topLeading, endPoint: .bottomTrailing)).clipShape(CustomCorner(corners: [.bottomLeft, .bottomRight], radius: 35)).shadow(color: .black.opacity(0.1), radius: 10, y: 5)
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Hi, \(username) 👋").font(.headline).foregroundColor(.white.opacity(0.8))
                    Text(LocalizationManager.shared.txt("app_name", lang: language)).font(.largeTitle).fontWeight(.heavy).foregroundColor(.white)
                    if urgentCount > 0 { Text("⚠️ \(urgentCount) \(LocalizationManager.shared.txt("expiring_soon", lang: language))").font(.caption).padding(6).background(Color.white.opacity(0.2)).cornerRadius(20).foregroundColor(.white) }
                    else { Text("✅ \(LocalizationManager.shared.txt("all_good", lang: language))").foregroundColor(.white.opacity(0.9)) }
                }
                Spacer()
                Button(action: onSettingsTap) { Image(systemName: "gearshape.fill").font(.title2).foregroundColor(.white).padding(10).background(Color.white.opacity(0.2)).clipShape(Circle()) }
            }.padding(.horizontal, 25).padding(.top, 40)
        }.ignoresSafeArea().frame(height: 180)
    }
}

struct FoodCard: View {
    let item: FoodItem; var onRemove: () -> Void
    @AppStorage("language") var language = "English"
    var body: some View {
        HStack(spacing: 15) {
            Text(item.emoji).font(.title).frame(width: 50, height: 50).background(Color.gray.opacity(0.1)).clipShape(Circle())
            VStack(alignment: .leading, spacing: 4) {
                Text(txt(item.name)).font(.headline).foregroundColor(.primary)
                Text(txt(item.category)).font(.caption).foregroundColor(.secondary)
            }
            Spacer()
            VStack(alignment: .trailing) {
                expiryBadge(days: item.daysRemaining)
                if item.daysRemaining < 0 { Button(action: onRemove) { HStack { Image(systemName: "trash.fill"); Text(txt("trash")) }.font(.caption2).bold().padding(.vertical, 4).padding(.horizontal, 12).background(Color.red.opacity(0.1)).foregroundColor(.red).cornerRadius(8) } }
                else { Button(action: onRemove) { Text(txt("eat")).font(.caption2).bold().padding(.vertical, 4).padding(.horizontal, 12).background(Color.blue.opacity(0.1)).foregroundColor(.blue).cornerRadius(8) } }
            }
        }.padding().background(Color(UIColor.secondarySystemGroupedBackground)).cornerRadius(20).shadow(color: Color.black.opacity(0.05), radius: 5, y: 2)
    }
    func txt(_ key: String) -> String { return LocalizationManager.shared.txt(key, lang: language) }
    @ViewBuilder func expiryBadge(days: Int) -> some View {
        if days < 0 { Text(txt("expired")).font(.caption).bold().foregroundColor(.red) }
        else if days == 0 { Text(txt("today")).font(.caption).bold().foregroundColor(.orange) }
        else { Text("\(days) \(txt("days_left"))").font(.caption).bold().foregroundColor(days <= 2 ? .orange : .green) }
    }
}

struct SuggestionPopup: View {
    let item: FoodItem?, themeColor: Color; var onConfirm: () -> Void, onClose: () -> Void
    @AppStorage("language") var language = "English"
    var body: some View {
        VStack(spacing: 20) {
            if let item = item {
                Text("✨ \(txt("recommended")) ✨").font(.headline).foregroundColor(.secondary)
                Text(item.emoji).font(.system(size: 80))
                VStack(spacing: 5) {
                    Text(txt(item.name)).font(.largeTitle).fontWeight(.bold).foregroundColor(.primary)
                    Text("\(txt("eat_before")) \(item.daysRemaining) \(txt("days_left"))").font(.caption).foregroundColor(.gray)
                }
                Button(action: onConfirm) { Text(txt("okay_eat")).bold().foregroundColor(.white).frame(maxWidth: .infinity).padding().background(themeColor).cornerRadius(15) }
            }
            Button(txt("close"), action: onClose).foregroundColor(.gray)
        }.padding(30).background(Color(UIColor.secondarySystemGroupedBackground)).cornerRadius(25).shadow(radius: 20).padding(40)
    }
    func txt(_ key: String) -> String { return LocalizationManager.shared.txt(key, lang: language) }
}

struct FloatingButton: View {
    let icon: String, color: Color, size: CGFloat, label: String, action: () -> Void
    init(icon: String, color: Color, size: CGFloat = 60.0, label: String, action: @escaping () -> Void) { self.icon = icon; self.color = color; self.size = size; self.label = label; self.action = action }
    var body: some View { Button(action: action) { Image(systemName: icon).font(.system(size: size * 0.4, weight: .bold)).foregroundColor(.white).frame(width: size, height: size).background(Circle().fill(color).shadow(color: color.opacity(0.4), radius: 8, y: 4)) }.accessibilityLabel(label) }
}

struct CustomCorner: Shape {
    var corners: UIRectCorner, radius: CGFloat
    func path(in rect: CGRect) -> Path { let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius)); return Path(path.cgPath) }
}

struct ContentView_Previews: PreviewProvider { static var previews: some View { ContentView() } }
