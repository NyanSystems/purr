+++
title = "Kerakli qo'shimchalar (3-qism)"
description = "Tilni yozish uchun kerakli bo'lgan kutubxonalar oldindan yaratib olamiz."
date = 2024-01-30
draft = false
slug = "lang-part-3"

[taxonomies]
categories = ["dasturlash tili"]
tags = ["nya", "kutubxonalar", "vektor", "bufer"]

[extra]
comments = true
+++

Ancha vaqt o’tib ketibdi oxirgi postni yozganimizdan bera. Katta tanaffus bo’lishiga asosan C dasturlash tilidagi yo’q kerakli kutubxonalar yozib olishimiz sababchi bo’ldi. Endi esa bir yugurib hammasini o’tib chiqamiz hozir.

**Ogohlantiruv:** Agar siz bu yerda nimalar bo'layotganini butunlay tushunmayotgan bo'lsangiz, iltimos bu sarguzashtlarimizni [boshidan o'qib chiqishni](/lang-part-1) maslahat beraman!

Oxirgi martasida biz tasavvur qilgan ko'rinishda kompilyator boshlang'ich arxitekturasini tuzib chuquvdik. Endi esa, bizga oldindan kerakli bo'lgan yordamchi kutubxonalar yozib olamiz. 

- Kutubxona? 
- Nimaga? 
- Aynan hozirmi?

**Ha!** Aynan hozir vaqti shu narsani. C da ko'plab abstraksiyalar mavjud emas, masalan HashMap, Vektor yoki Buferlar. Bularni hammasini C da o'zimiz qo'lda yozib chiqishimiz to'g'ri keladi. C da hech narsa yo'qligi eslaringizdan chiqmadi degan umiddaman ;) Keyinchalik shu narsalar bilan yana chalg'ish xohlamaymiz, shunga hozir yozib tashaganimiz ma'qul. Shu yerda biz endi nega 3-qism shuncha vaqt olganini birdaniga tushuntirib o'tamiz, bir taraflama sizlar tajribangiz uchun foydali bo'ladi degan umiddaman. Xullas, kutubxonani agar istasak alohida repozitoriyaga olishimiz mumkin, lekin birdaniga ichida shundayiga yozib ketsak ham bo'lar edi. Ajratib boshqa repozitoriyaga chiqarsak kodimizda faqat kompilyatorga tegishli logikalar qolardi va tozaroq turar edi. Chiqarmasak ham qo'rqinchli tarafi yo'q, hammasini helpers ichiga tiqib ketaveramiz. Bizda bo'lgan muammo (ha, biz ham sizlar bilan birga yozib borayabmiz bu narsani, faqat bizda ozgina shu narsa ustida tajribamiz bor), C bilan kutubxona yozib, uni CMake orqali Nix paket menejeri yordamida boshqa proyektda ishlatish bizning holatimizda ozgina og'riqli kechdi. 

Kutubxonalar ikki xil rejimda kompilyatsiya qilish mumkin, biri "Statik" bo'lsa, ikkinchisi "Shared". Orasidagi farq esa, "Shared" dagi kutubxonalarni C da yozilgan dastur kompilyatsiya bo'lib, ishga tushurilgandan keyin axtarib topib, ichidagi kerakli funksiya yoki datalardan foydalanadi. "Statik" da bo'lsa, C da yozilgan dasturimiz Statik kutubxonada kompilyatsiya bo'lish vaqti hamma narsani shu kompilyatsiya bo'layotgan dasturimiz ichiga tiqib ketadi, shunda har safar ishga tushurganda kutubxona axtarmasdan o'zini ichidan olib ishlataveradi kutubxonadagi kerakli narsalarni.

Biz statik paket chiqarib, uni Nix da boshqa nix paketga ulash bizni holatimizda ozgina og'riqli kechdi, nixpkgs ni ko'rdik, overlaydan tiqdik, hullas hammasi behuda. Balkim biron joyni tushunmayotgandirmiz. Shunga hozircha bu narsani ignor qila turib, yordamchi kutubxonalarni yozib ketaveramiz "helpers" papkasi ichida.

"helpers" papkasini ichida qariyb naxt 4 ta fayl yaratamiz:

- buffer.h
- buffer.c
- vector.h
- vector.c

Ho'sh, men hozir endi 1000 dan oshiq liniya kodni hammasini sizlarga birma-bir tushuntirib chaynab bera olmayman ming afsuski, shunga o'tirib yana o'zlaringiz izlanishlaringizga to'g'ri keladi keyingi postgacha. Ammo, ushbu protsess sizlarga yanada oson qilish uchun, [Ixtiyorjon](https://github.com/iabdukhoshimov) nomli safdoshimiz hozirda hamma header fayllarda nima funksiya nimaga kerakliligi haqida batafsil kod ni ichida dokumentatsiya yozib bormoqda va bu yozishmalar .h fayllardan topsangiz bo'ladi. Logikalar esa, o'zingiz tushunib turganlaringizday .c fayllar ichida. O'zgarishlarni [main branch](https://github.com/NyanSystems/nya)ida kuzatib borishingiz mumkin.  

> Ho'p, hozir biz endi nima qilaylik? 

Tanlov sizlarniki: 

- Xohlasalaringiz o'tirib o'qib, birma-bir qo'lda yozib chiqilar o'zlaringiz. Shunda qo'lda yozib ko'rsalaringiz keyin nima bo'layotganini "his" etasizlar.
- Yoki, shunday bizni [main branch](https://github.com/NyanSystems/nya)dan helpers papkadagi hamma narsani shunday o'zingizni proyektingizga ko'chirib qo'yib ishlatishingiz mumkin.

Nima tanlov qilishingizdan qat'i nazar, biz bu narsalar haqida Makefile va CMake ga inobatga olishini aytib o'tishimiz muqarrar. CMake chilar uchun yaxshi habar aytaman, hammasini bajarib bo'lgansizlar! Sizlar hech narsa qilmasalaringiz bo'ladi, chunki CMake faylilarda esilarda bo'lsa:

```cmake
include_directories(./include ./helpers)
```

va ...

```cmake
file(GLOB NYAN_SRC CONFIGURE_DEPENDS "include/*.h" "src/*.c" "helpers/*.c" "helpers/*.h")
```

deb ketish orqali hamma narsani qayerdan axtarib topib ulab ketish tushuntirganmiz. Faqat endi Makefile da GNU/GCC chilarimiz hamma narsani g'ijjalab birma bir tushuntirishlari kerak. Xo'sh tayyormisizlar bolajonlar?) Unda ketdik.

Tepada keltirilgan 4 ta faylni **[yaratgan yoki ko'chirgan]** imizdan keyin, *Makefileni* ochamizda, *./build/cprocess.o: ./src/cprocess.c* instruksiyamiz pasidan yozib ketaveramiz:

```makefile
./build/helpers/buffer.o: ./helpers/buffer.c
	gcc ./helpers/buffer.c ${INCLUDES} -o ./build/helpers/buffer.o -g -c

./build/helpers/vector.o: ./helpers/vector.c
	gcc ./helpers/vector.c ${INCLUDES} -o ./build/helpers/vector.o -g -c
```

va tepada OBJECTS ga ham qo'shib qo'yamiz. Natija taxminan shunday bo'lishi kerak:

```makefile
OBJECTS= ./build/compiler.o ./build/cprocess.o ./build/helpers/buffer.o ./build/helpers/vector.o
```

E'tibor bergan bo'lsalaringiz, `./build/helpers` deganmiz, ha, agar men o'ylayotgan narsani o'ylayotgan bo'lsangiz yanglishmadingiz! `build` papkasini ichida yana `helpers` degan papka yaratishimiz ham kerak bo'ladi. Demak, yaratdik, tushuntirdik, endi kompilyatsiya qilib ko'rishimiz kerak bo'ladi. Ammo, yozgan kutubxonalarimizni ham ishlatib ko'rgimiz keladi.

Endi bunday qilamiz, agar siz kutubxonalar endi yozish boshlagan bo'lsangiz, shunday hozir bir kompilyatsiya qilib ko'ravering, agar ko'chirib o'tkazib yoki oxirigacha yozib chiqsangiz, keyin `main.c` ichida asosiy `main` funksiyani ichida shu narsani tepadan yozvoramiz shunday qilib: 

```c
int main()
{
  // ==============================================
  // Vektorlarni sinab ko'rish uchun yozilgan kod
  // ==============================================
  struct vector *vec = vector_create(sizeof(int));

  int x = 50;
  vector_push(vec, &x);
  x = 20;
  vector_push(vec, &x);

  vector_pop(vec);

  vector_set_peek_pointer(vec, 0);
  int *ptr = vector_peek(vec);

  while (ptr) {
    printf("%i\n", *ptr);
    ptr = vector_peek(vec);
  }
  // ==============================================

  ... oldin yozgan boshqa narsalarimiz

}
```

Bu orqali biz yozgan vektorlar kutubxonamizni sinab ko'ramiz va agar miyangizda ushbu kodni ishga tushurgan bo'lsangiz, natija oldindan 50 ligini bilasiz =) Qanday qilib kompilyatsiya qilib ishga tushurish eslatishim shart emas, a?) Ho'sh, ishga tushurib ko'rsak, terminalda shunga o'xshash natija ko'rsatishi kerak:

```
50
Hamma narsa muvaffaqiyatli kompilyatsiya qilindi
Salom Dunyo!
```

Uree, kutubxonalar ham ishlayabdi! Endi keyingi post chiqguncha analiz qilib bir o'rganib chiqasizlar. Keyingi mavzu parserlar haqida bo'ladi va bu kompilyator eng og'riqli va o'ta qiyin joyi hisoblanadi, haa... jiddiy bo'ladi... Shunga yaxshilab shijoat va qat'iyat bilan kelasizlar keyingi safarga!

> Ogohlantiruv: Endi bir gap, men har doim ham bu yerda kodlarni yoki tushuntirishlarni chiroyli va to'g'ri yozib ketmasligim mumkin, ham sizlar ham o'zlaringiz sal-pal izlanishlaringiz kerak, bo'lmasa o'smaysizlar, chin so'zim. Shunga tutoriallar tugagandan keyin sal o'tirib [NyanSystems/nya](https://github.com/NyanSystems/nya) dagi kodlardan qarab, xato kamchiliglarni to'ldirib olasizlar. Men sizlarga har tutorialda yozilgan paytgi commitlar linkini tashlab ketishim mumkin endi oldinga jaa o'tib ketib  umumman o'zgarib ketgan kod ko'rmasligilar uchun. Mana bugungi tutorial o'zi [[main branch]](https://github.com/NyanSystems/nya) ga asoslangan. Ozgina qo'shimchalari bor, uni keyingi tutorialdan qamrab olishga harakat qilaman!