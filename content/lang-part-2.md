+++
title = "Arxitekturani tuzib boramiz (2-qism)"
description = "Tayyorlab bo'lgach, endi rejalar qilgan holda yozishni boshlaymiz."
date = 2024-01-19
draft = false
slug = "lang-part-2"

[taxonomies]
categories = ["dasturlash tili"]
tags = ["nya", "struktura"]

[extra]
comments = true
+++

As-salo-mu, a-ley-ko'm! Qani darsimizni yana bugun boshlaymiz. Bugun endi sal-pal kod yozish boshlasak ham bo'ladi, har qalay o'tgan gal hamma narsani to'g'irlab olgan edik-a?) Endi gap qisqasi bunday, hozir kimdir shu postlarni ubu biron joylaridan olib tashlab yuborishi mumkin boshqalarga, agar shu odam kelib hozir hech narsani tushunmasa, undanda achinarli ahvol bo'lishi mumkin emas. Shunga bundan keyin bir kichik ogohlantirish yozib ketaman keyingi postlardan, bilmaganlar boshidan kelishi uchun. 

**Ogohlantiruv:** Agar siz bu yerda nimalar bo'layotganini butunlay tushunmayotgan bo'lsangiz, iltimos bu sarguzashtlarimizni [boshidan o'qib chiqishni](/lang-part-1) maslahat beraman!

Loyihada bizda hozir `main.c` bor va uni qiladigan asosiy vazifasi bu ekranda `Salom Dunyo!` chiqarish holos. Agar siz zamonaviy dinamik dasturlash tillaridan kelayotgan bo'lsangiz, sizni oldinda judayam ko'p nazariy fikrlash kutayotganini bilan ogohlantirmoqchiman. Agar C da yozgan va tajribangiz bo'lsa, nima deyayotganimni tushunib turibsiz.

> Xo'sh, bu bilan nima demoqchiman?

Gap shundaki, C va shunga o'xshash dasturlash tillarida siz har doim ham natijani ko'rolmaysiz python yoki javascript tillariga kabi, ba'zan nazariya orqali fikrlash yordamida dastur yozib ketishingizga to'g'ri keladi. Har doim ham orqada bo'layotgan protsessni ko'ra ololmaysiz, uni ham nazariya shaklida fikrlash doirasida yozib borishga to'g'ri keladi. Agar hali ham nima deyayotganimni tushunmayotgan bo'lsangiz, praktika qilib borish doirasida tushunib olasiz kelayotgan yaqin kelajakda. Hozircha bu narsani taxminan joyida texnik topshiriqlarsiz arxitektura yoki butun infrastrukturani hayolda chizish va yozib ketish deb tasavvur qilsangiz bo'ladi.

### O'zimiz yoqtirgan redaktorni loyiha ichida ochvolamiz va qani ketdik...

Boshlanishiga `src/` papkani ni ichida `compiler.c` degan fayl yaratib, ichini ochamiz. Bitta funksiya yaratamiz.

```c
int compile_file(const char* filename, const char* out_filename, int flags)
{   
    return 0;
}
```

funksiya o'ziga `filename` (kompilyatsiya qilinishi kerak bo'lgan fayl nomi), `out_filename` (kompilyatsiya bo'lgan dastur qanday va qayerda saqlanishi kerak) va `flags` (kompilyatsiya jarayoni uchun qo'shimcha ko'rsatkichlar) argumentlarini qabul qiladi. Funksiya `hozirchalikga` '0' qaytarib turadi (0 bu pastki darajali dasturlash terminidan ko'pincha ish muvaffaqiyatli bajarildi degan manoda ishlatiladi, 1 bo'lsa xatolik yuz berdi degan bo'ladi), hali keyinchalik bu yerga yana ko'p qaytib kelamiz. Endi esa shu faylimiz uchun header fayl yaratib olamiz. Headerlar turishi uchun biz alohida joy ochganmiz va bu `includes` papkasi. Shu papkani ichida `compiler.h` degan fayl yaratamiz va ichida:

```c
#ifndef NYA_COMPILER_H
#define NYA_COMPILER_H

// shu yerga yozasizlar keyinchalik kodlarni

#endif
```

yozib qo'yamiz. Bu bilan biz, C kompilyatoriga birinchi marotaba `compiler.c` faylimizdagi yozilgan narsalar ro'yxati bilan tanishtiramiz. Bu bizga bir narsani ikki marotaba e'lon qilishdan yoki strukturani chalkashtirishdan asraydi. Internetda [`#include guards`](https://en.wikipedia.org/wiki/Include_guard) nomi bilan qidirsangiz bo'ladi ko'proq ma'lumot. Endi shuni o'rtasiga yozamiz.

```c
int compile_file(const char* filename, const char* out_filename, int flags);
```

Tortinmasdan boyagi `compiler.c` fayldan birinchi qismini chopib bu yerga qo'yib, oxiriga nuqta vergul qo'yib qo'ysangiz bo'ladi. C dasturlash tili sizlarni yangi zamonaviy tillaringizga o'xshab to'g'ridan to'g'ri fayllarni kodlaridan o'qib hamma narsani import qila ololmaydi. C kompilyatori hamma fayllarni birma-bir alohida kompilyatsiya qilib chiqib, keyin header faylga qarab bir-biriga ulaydi. Yana judayam ko'p o'ziga yarasha ishlatiladigan joylari bor header fayllarni, masalan modullashtirish, bunda biz bir necha minglab fayllarga kodlarni yozib tashayveramiz va oxirida bitta joydan (fayldan) chiqib ketadigan qilishimiz mumkin, yoki kodlarni toza tartibda saqlash, ya'ni funksiya nima qaytarishi va nima qabul qilishi header fayl ichida, nima qilishi esa `.c` fayl ichida va ko'z charchatib qo'ymaydi ming qatorlab kodlarni ichidan o'zimizga kerakli narsani qidirayotganimizda.

Endi yana yangi `cprocess.c` nomli fayl yaratamiz `src/` papkani ichida. Bu faylda biz ko'proq kompilyatsiya jarayoni protsessini yaratish va boshqarishga oid funksiyalar yozib boramiz. Keyin `compiler.h` fayliga qaytamizda, shu tepadan (tepadan deganda `#define NYA_COMPILER_H` dan pasini nazarda tutayabman, ya'ni hamma `#define NYA_COMPILER_H` va `#endif` ichidan qaraganda tepa) shu kodchani yozvoramiz:

```c
struct compile_process 
{

}
```

endi esa birdaniga `cprocess.c` faylini ochib olamizda ichiga shuni yozamiz:

```c
struct compile_process* compile_process_create(const char* filename, const char* filename_out, int flags)
{

}
```

bu funksiya va funksiyamiz compile_process struct (kelilar shu struct yoki strukturani ko'proq obyekt, yoki quti deb tasavvur qilamiz, uni ichiga narsa qo'yamiz va kerakli payt ichidan olib ishlatamiz. ko'proq ma'lumotlarni tartibli saqlash uchun ishlatamiz. faqat oop chilar diqqatiga, bu obyektda metod yozolmaymiz, faqat statelar) pointeri qaytaradi. Endi esa shu funksiyani tepasidan bir narsa yozib ketaylik:

```c
#include <stdio.h>
```

bu C ning standard kutubxonasi, unda birinchi darajali eng kerakli funksiya va strukturalarga boy. Standard kutubxona bilan deyarli hamma narsa yozsa bo'ladi boshidan agar fantaziyangiz juda kuchli bo'lsa. Ozgina yoqimsiz-u, chunki ko'proq kod yozasizlar internetdagi kutubxona ishlatgandan ko'ra, lekin istalgan yo'nalishda istalgan tilda (JavaScript, Python) birgina std (standard kutubxona qisqartmasi) bilan yashasa ham bo'ladi har xil npm yoki pip ga o'xshagan paket menejerlaridan hech narsa tortmasdan. Indan keyin, shu endi boyagi `compile_process_create` funksiyamiz ichiga: 

```c
    FILE* file = fopen(filename, "r");
```

yozamiz. Bu bilan biz filename (tepada biz shuni funksiya argumentida oshirgandik esingizda bo'lsa `const char* filename` deb) nomli faylni faqat `o'qish ruxsati` bilan ochamiz. Endi bitta narsa bor, har doim ham fayl ocha ololmasligi mumkin, unday holatda biz buni ham inobatga olishimiz kerak. Shu kodni pasidan:

```c
    if (!file) 
    {
        return NULL;
    }
```

yozamiz va bo'ldi, bunisi pishdi. Endi bilamiz, fayl muvaffaqiyatli ochildimi, yo'qmi. Pasidan shunday:

```c
    FILE* out_file = fopen();
```

yozishimiz bilan biz kompilyatorimizdan chiqgan natija qayerda saqlash kerak bo'lsa o'sha yerda "yozish" ruxsati bilan fayl ochamiz. Hamda, biron noma'lum xatoliklar bilan fayl ochilmasligiyam mumkin, unaqa holat uchun:

```c
    if (!out_file)
    {
        return NULL;
    }
```

...oddiygina NULL qaytarib qo'yamiz. Endi bir narsa hayolga keladi, chiqadigan fayl nomi shart bo'lishi kerak emas-ku... To'g'rimi? Shunga endi kodni bunga o'zgartiramiz va shunday ko'rinishi kerak bo'ladi:

```c
    FILE *out_file = NULL;
    if (filename_out)
    {
        out_file = fopen(filename_out, "w");
        if (!out_file)
        {
            return NULL;
        }
    }
```

va shunda bizda out_file o'zi boshidan noaniq bo'ladi, agar biron nom oshirilgan bo'lsa, biron anniq qiymatga to'g'irlab qo'yamiz. Shunda agar foydalanuvchi filename_out oshirmasa, biz hech narsa yaratmaymiz (fayl ochmaymiz). Ba'zida biz biron narsani terminal o'zida ko'rish uchun kompilyatsiya qilamiz, shart emas alohida biron faylga yozib o'tirish. Shuning uchun, foydalanuvchini majburlamaymiz biron chiqadigan fayl nomi berishga. 

Endi esa biz kompilyatorimiz uchun anniq protsess yaratamiz. Buning uchun:

```c
struct compile_process* process = calloc(1, sizeof(struct compile_process))
```

faqat esda tutamiz, calloc bu standard kutubxonadan olingan yordamchi funksiya, shuning uchun tepaga bir boya yozgan stdio mizni tagidan stdlib qo'shib qo'yamiz. Agar nima deganimni tushunmayotgan bo'lsangiz, boyagi `#include <stdio.h>` ni tagidan `#include <stdlib.h>` ni yozib qo'ying. Undan keyin esa shu stdlib yana tagida `#include "../includes/compiler.h"` yozib qo'yasiz, chunki callocga biz `compiler.h` da yozilgan `compile_process` structini oshirayabmiz. Shunda calloc va compile_process structi qayerdan kelayotganini C kompilyatorimiz biladi. Hamda, e'tibor bergan bo'lsangiz, calloc o'ziniz ichida 2 ta argument olayabdi, birinchis bu 1 ya'ni a'zolar soni, shuncha element uchun joy ajratiladi va ikkinchisi bu ajratilishi kerak bo'lgan element hajmi, biz compile_process uchun yetadigan joy ajratayabmiz. Joy ajratilish va o'sishi dinamik tarzda kechadi. Agar OOP chilar bo'lsa, ularga oddiygina obyekt initsializatsiya qildik desak bo'ladi, faqat xotira chegaralangan. Endi esa bizni `compiler.h` ichida bo'm-bo'sh yotgan `compile_process` structimizga ma'lumotlar joylashtirish uchun qanday joylashtirilishi uchun ma'lumotlar berib chiqamiz. 

```c
// FILE* ishlatganimiz uchun teparoqda yozib ketamiz
#include <stdio.h> 

struct compile_process
{
    // Fayllar qanday kompilyatsiya bo'lishi kerakligi 
    // haqidagi ko'rsatmalar shu yerda saqlaymiz
    int flags;

    // Kompilyatsiya qilish kerak bo'lgan fayl haqida
    // ma'lumotlar
    struct compiler_process_input_file
    {
        // Faylimizga pointer
        FILE* fp;
        // Absolyut joylashuv manzili
        const char* abs_path;
    } cfile;

    // Chiqarilgan natija shu yerda ushlab turamiz
    FILE* ofile;
}
```

Shakl berib chiqgach, endi boyagi protsessda shu shakl ichiga ma'lumotlarni joylashtirish boshlaymiz:

```c
    // Boyagi ochilgan joy
    struct compile_process* process ...

    // Olgan flagimiz shu yerga joylashtirib qo'yamiz
    process->flags = flags;

    // Tepada ochib o'qib qo'ygan faylimizga pointer (ko'rsatgich)
    // shu yerga bir olib qo'yamiz
    process->cfile.fp = file;

    // Chiqarishimiz kerak bo'lgan joyni pointerchasini 
    // ham olib qo'yamiz
    process->ofile = out_file;
```

Mazzami sizlarga a?) Vo'y vo'yeeey, endi shu protsessni boshqa funksiyalarda ishlatish uchun shunday pasidan qaytarib qo'yamiz!

```c
  return process;
```

Vaaaa deyarli bu yerda ishimiz bitay deb qoldi. Faqat endi shu .c faylda yozgan funksiyamiz borligi haqida `compiler.h` da aytib ketishimiz kerak. Shunday...

```c
struct compile_process *compile_process_create(const char *filename, const char *filename_out, int flags);
```

ni ko'chirib olamizda tepadan, `compiler.h` ga o'tib, `int compile_file` referensimiz tagidan joylashtirib qo'yamiz.

Miyacha qizib ketdi-ya?) Endi eee bir eslaringizda bo'lsa, `compiler.c` degan faylcha yaratib qo'yuvdik bir boshida keyinchalik hamma narsani shu yozgani... Endi o'sha qaytib boramiz, davom ettiramiz! Shunday kirib shu fayl ichida `int compile_file` funksiyamiz ichidan...

```c
  struct compile_process* process = compile_process_create(filename, out_filename, flags);
```

`compile_process_create` bilan `compile_process` ga qizil yonadi redaktorimizda, chunki tepada biz bu narsalar `compiler.h` dan kelayotganini aytmaganmiz. Tezda eng tepada `#include "../includes/compiler.h"` deb yozib qo'yamiz. Kodimizga qaytadigan bo'lsak, biz bu yerda protsess yaratish funksiyamiz yordamida protsess yaratdik. Bilamizki, agar biron xatolik yuz bersa `compile_process_create` ichida, albatta NULL qaytaradi. Shuning uchun NULL mi yoki yo'qligiga validatsiya qilishni boshlaymiz:

```c
    if (!process)
        return COMPILER_FAILED_WITH_ERRORS;
```

"Ebe? Mana bu COMPILER_FAILED_WITH_ERRORS qayerdan keldi?" degan savollar paydo bo'ladi to'g'rimi?) Ho'sh, bu narsani endi biz hozir yaratamiz `compiler.h` ichida. Yaratishimizdan maqsadimiz esa, C da holbuki sizlarni zamonaviy tililarga o'xshagan Exception degan narsa yo'q afsuski, uni o'rniga biz o'zimiz har xil holatlar uchun xatoliklar variatsiyalarini yozib chiqamiz. Shuning uchun endi `compiler.h` ichini ochvolib, #include lar dan pasidan yozamib ketamiz:

```c
enum
{
    // Agar dasturimiz muvaffaqiyatli
    // bajarsa ishini, shuni qaytaramiz
    COMPILER_FILE_COMPILED_OK,

    // Agar biron xatolik yuz bersa,
    // shuni qaytarvoramiz
    COMPILER_FAILED_WITH_ERRORS
};
```

Endi esa `compiler.c` da boshlagan ishimizni tugatib qo'yamiz. 

```c
    // Qandaydir xatolik chiqdi, demak...
    if (!process)
        // Xatolik yuz berganlik haqidagi 
        //xatolik variatsiyasini qaytaramiz
        return COMPILER_FAILED_WITH_ERRORS;

    // TODO: Leksik analiz qilish kerak bu yerda

    // TODO: Parsing qilish kerak bu yerda

    // TODO: kod generatsiya qilish kerak bu yerda

    // Ureee! Muvaffaqiyatli ishini
    // bajardi kompilyatorimiz
    return COMPILER_FILE_COMPILED_OK;
```

### BO'LDI! TUGADI HAMMASI! KOMPYUTERNI OYNADAN ULOQTIRING!!!

Hazil, hazil... Hali hammasi oldinda ;) Ana endi bir GNU/GCC tanlagan do'stlarimiz sharmandasini chiqarayli-ga GCC sevishgani uchun XD Makefile chalarni bir ochib, `all` ni pasidan yozamiz.

```makefile
./build/compiler.o: ./src/compiler.c
	gcc ./src/compiler.c ${INCLUDES} -o ./build/compiler.o -g -c
```

bu bilan biz Makefilega qayerdan nimani olib turib, obyekt referenslarini yaratishni aytamiz. Agar batafsil tushuntiradik bo'lsak:

```makefile
./build/compiler.o: ./src/compiler.c
^^^^^^^^^^^^^^^^^^^ ^^^^^^^^^^^^^^^^
 instruksiyaga nom  qayerdan nimani?

    gcc ./src/compiler.c ${INCLUDES} -o  ./build/compiler.o -g  -c
    ^^^ ^^^^^^^^^^^^^^^^ ^^^^^^^^^^^ ^^^ ^^^^^^^^^^^^^^^^^^ ^^^ ^^^
kompilyator     |             |       |           |          |   |
        qayerdan topsin       |       |           |  debug uchun |
                  headerlar qayerda?  |           |   hech narsaga ulab tashama
                             natija chiqarilsin   |
                                       obyekt tarzida shu yerga
```

Umid qilamanki, tushunarli bo'ldi hammasi. Endi pasidan yana qolgan yaratib tashagan fayllarimiz uchun ham yozib chiqamiz.

```makefile
# cprocess.c faylimiz uchun
./build/cprocess.o: ./src/cprocess.c
	gcc ./src/cprocess.c ${INCLUDES} -o ./build/cprocess.o -g -c
```

Va bolajonlar, yana bir narsani esda tuting! Asosiy kompilyatsiya qilish buyrug'imiz bu bizda `all` va har safar biz birma bir kompilyatsiya qilib chiqib o'tirishga hayotimiz qisqalik qiladi. Shunga har safar instruksiyaga yaratganimizda uni nomini `OBJECTS=` ga space bilan ajratgan holda qo'shib boramiz. Hozirgi holatimizda Objects shunday bo'lishi kerak:

```makefile
OBJECTS= ./build/compiler.o ./build/cprocess.o
```

Mana bizni bugungi sarguzashtlarimiz oxiriga yetay deb qoldi. Faqat endi shuncha qilgan mehnatlarimiz bir sinab ko'rishimiz kerak. Uning uchun endi `main.c` ni ochamizda, asosiy (main) funksiyamiz ichidan yozishni boshlaymiz:

```c
    // Asosiy kompilyatsiya qilish funksiyamiz ishga tushuramiz
    // Faqat tepada "../includes/compiler.h" include qilish esdan
    // chiqmasin!
    int res = compile_file("./test/simple.c", "./test/simple", 0);

    // Agar funksiyamiz muvaffaqiyatli bajargan bo'lsa ishini...
    if (res == COMPILER_FILE_COMPILED_OK)
    {
        // Shunchaki kulib qo'yamiz, qaytaraman, kubib qo'yamiz!
        printf("Hamma narsa muvaffaqiyatli kompilyatsiya qilindi\n");
    }
    // Aks holda
    else if (res == COMPILER_FAILED_WITH_ERRORS)
    {
        // Yig'lab qo'yamiz, qaytaraman, yig'lab qo'yamiz...
        printf("Kompilyatsiyada xatolik yuz berdi\n");
    }
    // Agar nimalar bo'layotganini tushunmay qolsak
    else
    {
        // Programmamiz nasha otgani haqida gapirib qo'yamiz...
        printf("Kompilyatsion fayl uchun noma'lum javob qaytarildi\n");
    }

    return 0;
```

Biz bilamizki dasturimiz ishga tushgandan birdaniga test papkasini ichidan simple.c degan fayl axtarish boshlaydi. Biz lekin bu narsalar yaratmagan edi, shunga endi `test` degan papka yaratib ichida `simple.c` degan fayl ochib qo'yamiz va shu fayl ichida oddiygina Salom, Dunyo! tashlab qo'yamiz:

```c
int main()
{
    return 0;
}
```

Tamom vassalom. Endi esa dastur ishga tushuramiz. Bunisi endi men aytmayman, har xolda eslasalaringiz kerak o'tgan safar qanday kompilyatsiya qilganlaringizni hay? Ishga tushurib ko'ring va agar hammasi o'xshagan bo'lsa `Hamma narsa muvaffaqiyatli kompilyatsiya qilindi` habarini ko'rsatishi kerak, bo'lmasam o'tirib bir kod review qilasizlar ;)

Endi bir gap, men har doim ham bu yerda kodlarni chiroyli va to'g'ri yozib ketmasligim mumkin, ham sizlar ham o'zlaringiz sal-pal izlanishlaringiz kerak, bo'lmasa o'smaysizlar, chin so'zim. Shunga tutoriallar tugagandan keyin sal o'tirib [NyanSystems/nya](https://github.com/NyanSystems/nya) dagi kodlardan qarab, xato kamchiliglarni to'ldirib olasizlar. Men sizlarga har tutorialda yozilgan paytgi commitlar linkini tashlab ketishim mumkin endi oldinga jaa o'tib ketib  umumman o'zgarib ketgan kod ko'rmasligilar uchun. Mana bugungi tutorial o'zi [[9f0386 kommit]](https://github.com/NyanSystems/nya/tree/9f0386f760ad07fbdde51522f9261f89eb01b397) ga asoslangan. Ozgina qo'shimchalari bor, uni keyingi tutorialdan qamrab olishga harakat qilaman!