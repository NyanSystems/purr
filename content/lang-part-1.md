+++
title = "Boshlaymizmi? (1-qism)"
description = "Dasturlash tilimiz yozishni boshlashdan avval muhitni tayyorlab olamiz."
date = 2024-01-17
draft = false
slug = "lang-part-1"

[taxonomies]
categories = ["dasturlash tili"]
tags = ["nya", "boshlangich"]

[extra]
comments = true
+++

**Ogohlantiruv:** orada bir-bir yaqin olib hazil qilamiz, to’g’ri tushunasizlar degan umiddaman. 

Agar sizda hozir Windows o’rnatilgan bo’lsa, shunday bu blogdan chiqib ketish tugmasini behijolat bosavering. Ushbu blog/roadmap/taasurot/hikoya faqat *nix oilasidagi operatsion tizim foydalanuvchilariga moslangan. Agar dasturchi sifatida o’zingizni hurmat qilsangiz, borib biron Linux yoki MacOS ob kelib, keyin o’qishda davom etavering. 

Ho’sh, ho’sh, ho’sh… Demak, biz C da yozmoqchi ediga?… Unda, C statik kompilyatsion til ekan, biz dasturchi muhitini yaratib olishimizga to’g’ri keladi, hamda, zamonaviy “Rust” yoki “Go” larga o’xshab paket menejerlari bilan birga kelmaydi. Tanlov katta, lekin preferens bitta. Men (biz desak ham bo’ladi) Chriss Lattner bratni (shaxsan o’zim, @orzklv) judayam hurmat qilaman. Ham uni o’zini tajribasi va qilgan konsepsiyalari uchun, ham yaratgan ajoyib “LLVM” nomli kompilyatorlar infrastrukturasi uchun. Hammada tanlov har xil, kimlardir GNU/GCC tarafdori va bu yomon narsa emas. Tanlovlar ko’proq beradigan qulaylik va standartizatsiya qanchalik qamrab olishiga bog’liq. Agar solishtiradigan bo’lsak bir-biri bilan o’z tajribamdan kelib chiqib, LLVM GCC ga nisbatan yangiliklarni ozgina sekinlik bilan chiqarishadi, lekin LLVM infrastrukturasidan o’zingiz loyihangiga ABI orqali biriktirib API lardan foydalanish judayam qulay va oson. ABI va uning tuzilishi odam qonini ichib yubormaydi, hamda dokumentatsiyasi ham odam bashara. Oddiy jit qo’shimchasini qamrab olish uchun libgccjit da ekstra 400 qator binding yozib chiqishga to’g’ri keladi, ammo gcc ishlatilishi judayam oddiy va ergonomik hisoblanadi LLVM ga qaraganda. Masalan GCC da debugger va kompilyator bitta setka tarzida taqdim etiladi, LLVM da esa alohida meta paketlar hammasi. Xullas, ikkalasi ham o’ziga yarasha +/- lari bor, lekin gapni qisqa qiladigan bo’lsak, ishlatishga gcc, integratsiya va loyiha uchun LLVM zo’r ketadi. 

Keling endi qanday qilib bu matahlarni ishlatish tushuntiraman. GCC ishlatish uchun agar siz Linux da bo’lsangiz, sizning Linux distributivingizdan dev utils paketlar setkasini yuklashingiz kerak bo’ladi. Dev setka deganda men kompilyator va hamma dasturchiga as qotadigan paketlar yig’indisini nazarda tutayabman va deyarli hamma linux distributivlarda bu narsa mavjud. Masalan, Arch Linux da bu base-devel, buni ichida GCC kompilayorlar oilasi va instrumentlari, hamda dastur paketlashda as qotadigan instrumentlar mavjud. Adashmasam ubuntu da bu build-essentials. MacOS da esa setka tushunchasi yo’q, o’rniga hamma narsani birma bir yuklab chiqish kerak bo’ladi, albatta agar homebrew ishlatayotgan bo’lsangiz. Ho’sh, agar xulosalaydigan bo’lsak, bizda shunaqa holat bo’lib turibdi.

#### Agar siz, o’qiyotgan odam, LLVM bilan ketishni xohlasangiz, siz shularni o’rnatishigniz kerak bo’ladi:
- llvm (eng oxirgi versiyasi)
- lldb (agar llvm ichida kelmasa)
- cmake
- cmakeCurses
- clang (agar llvm ichida kelmasa)

#### Agar siz GNU/GCC setkalaridan foydalanaman desangiz:
- gcc
- make (yoki gnumake deyishadi alternativ)
- gdb
- valgrind

Agar o’rnatib keyingi bosqichga shay bo’lib turgan bo’lsangiz, unda loyihani yaratishdan boshlaymiz! Endi bolajonlar, bitta narsani oldindan tushunib olishlaringiz xohlayman, LLVM yoki GCC larda paketlar menejeri degan tushuncha yo’q, ko’pi bilan “build manager” agar oxirgi yangilanishlarda git proyekt o’zi tortib qo’shish qo’shishmagan bo’lishsa va bizning build menejerlarimiz sizlarni paket menejerlaringiz oldida g’irt omi va ularga birma bir hamma narsani butunlay boshidan tushuntirib berishimizga to’g’ri keladi. Men loyiha yozish paytida ham cmake (llvm), ham make (gcc) bir vaqt o’zida qo’llab quvvatlashga qaror qilganim sababli ikki xil tutorial yozib ketaveraman paragraf bilan ajratib bir-biridan.

LLVM chilarimiz diqqatiga (GNU chilar, pastroqda sizlarni chaqirganman, tushingizlar pastga), loyihani yaratish uchun, biz birinchi bo’lib CMakeLists.txt degan fayl qo’lda yaratishdan boshlaymiz. Keyin ichiga yozib ketaveramiz. Kefteme, birinchi qatordan, 

```cmake
cmake_minimum_required(VERSION 3.26)
```

Bu bilan men loyiham eng kamida cmakening 3.26 chi versiyasi orqali ishlaydi deb aytmoqchiman. CMake yaratganlar judayam yaxshi ko’rishadi eskirgan konflikt API larni chiqarib tashashni, shunga cmake faylda ko’rsatib o’tib ketishimiz kerak agar loyihamiz ham kelajakda, ham boshqalarda ishlashini xohlasak. Keyin esa 

```cmake
project(nya C)
```

deb yozvoramiz. Bunda loyiha nomi va u qaysi til ishlatishini ko’rsatamiz. CMake C++ loyihalarda ham ishlatiladi, shunga ko’rsatib ketish kerak bo’ladi. Keyin pasidan

```cmake
include_directories(./include ./helpers)
```

yozish orqali qayerdan header fayllarni topishni tushuntiramiz va ketidan tezgina “include” va “helpers” degan papkachalarni yaratib qo’yamiz loyiha turgan joydan (project root path deymiz inglizchada). Undanam pasidan

```cmake
set(CMAKE_C_STANDARD 23)
```

tiqishtiramiz. Bu esa nechinchi avlod standartizatsiyasini ishlatish belgilab beradi. Masalan C99 bor, C++11 bor, C++14, 23 va hokazo. Har bir evolyutsiya nimadir yangi narsa olib kiradi (ammo nimagadir C++ da har yangi evolyutsiya bilan omilashaveradi… ha-ha, hazil). Biz eng yangi C ishlatamiz (xotya 99 ishlatdik nima, 23 ishlatdik nima… ha-ha). Endi esa fayllarimiz haqida CMake ga tushuntirib beramiz. Men tartibli perfeksionistman, hamma narsani chiroyli va tartibda qilib borishni yoqitraman. Odamlar hamma narsani proyekt boshida saqlashsa, men header fayllarni “include” papkasida, C kodlarni “src” va qo’shimcha yordamchi codebaselarni “helpers” da… Shunga, endi CMake ga

```cmake
file(GLOB nyan_SRC CONFIGURE_DEPENDS "include/*.h" "src/*.c" "helpers/*.c" "helpers/*.h")
```

yozish bilan biz, shu papkalar ichidan nimalar axtarish tushuntirib beramiz. Adashmasam, helpers va include yaratuvdik, endi src papkasini ham yaratib qo’yamiz va olg’a. Keyin,

```cmake
add_executable(nya ${nyan_SRC})
```

deb yozib qo’yamiz. Bu bilan biz CMake ga boya file(… deb qayerlardan nima qidirish ko’rsatdik-ku, shular ichidan asosiy boshlang’ich nuqtani topib “main function deymiz inglizchada” ishga tushuriluvchi dastur binarnik yaratishni aytamiz. E’tibor berilar, …GLOB nyan_SRC CONF… va …able(nya ${nyan_SRC})… nuqta. Oxiri qoldi va bu

```cmake
set(CMAKE_BUILD_TYPE Debug)
```

deb yozib qo’yamiz pasidan. Bu bilan esa kompilyatsiya qilgan dasturimiz ichiga xatoliklar topish uchun debag marka osa olish qobiliyatini ochib beradi. Reliz chiqarganda albatta biron kimdir binarnikimiz ichida nima borligini axtarib timirskilanib yurmasligi uchun o’chirib qo’yamiz, hozircha esa o’zimiz uchun yoqiq tursin. Shunday qilib agar hamma qadamlar to’g’ri bajarib borgan bo’lsangiz, taxminan [shunday fayl](https://github.com/NyanSystems/nya/blob/9f0386f760ad07fbdde51522f9261f89eb01b397/CMakeLists.txt) chiqishi kerak sizlarda. Bu fayldagi biron nima sizda yo’q bo’lsa, hammasi joyida, biz shu joylariga yetib bormadik xolos. Tekshirib oling va qani olg’a.

Haa GNU chilar, tayyormisizlar?) Tayyor turilar, hozir yaxshigina itarilamiz… Makefile yozish CMake nikiga qaraganda undanda gemoroyroq. Qani, loyiha asosiy joyidan “Makefile” degan fayl yaratamiz va ichiga:

```makefile
OBJECTS=
INCLUDES= -I./include -I./helpers
```

deb, tashab qo’yamiz va “include” bilan “helpers” degan papkalarni yaratib qo’yamiz. Sal keyinroq tushuntirib beraman OBJECTS nimaga kerakligini, INCLUDES esa biz gcc ga qayerdan header fayllarni topish kerakliligini aytayabmiz. Keyin esa pasidan (qo’shimcha bir qator tashab agar malol kelmasa):

```makefile
all: ${OBJECTS}
    gcc src/main.c ${INCLUDES} ${OBJECTS} -g -o ./build/nyagcc
```

va yozishimiz bilanoq, loyiha joyidan “build” bilan “src” papkasini yaratib ketamiz. Bu bilan biz gcc ga qanday qilib loyihani kompilyatsiya qilish kerakliligini tushuntirib ketayabmiz. Kompilyatsiya qilingan loyiha build papkasini ichida nyagcc ishga tushuvchi fayl ko’rinishida paydo bo’ladi. Pasidan esa yana

```makefile
clean:
 rm ./build/nyagcc
 rm -rf ${OBJECTS}
```

yozib qo’yamiz, ishlab bo’lgandan keyin keraksiz qayta generatsiya bo’luvchi chiqindilardan tozalab turishga. Agar hamma qadamlarni to’g’ri bajargan bo’lsangiz, sizlarda [shu faylga](https://github.com/NyanSystems/nya/blob/9f0386f760ad07fbdde51522f9261f89eb01b397/Makefile) o’xshash bo’lishi kerak, faqat vahima qilmaylar! Nimaiki `./build/…` deb boshlagan narsa bo’lsa shuni ignor qililar, bo’ldi… Lekin oldindan shu narsaga o’zilarni tayyorlab borilar, o’zilar shu narsaga ko’ndilar, men majburlamadim )… 

Va nihoyat eng boshlang’ich instruksiyalar yozib olgach, `src` pakasini ichida `main.c` degan fayl yaratib ichiga shu code chani tashab qo’yamiz.

```c
#include <stdio.h>

int main() {
  printf("Salom Dunyo!\n");
  return 0;
}
```

Keyin esa, terminalchani CMakeLists.txt yoki Makefile turgan joydan agar cmake da boshlangan bo’lsa loyihani,

```bash
# Agar build papka haliyam yaratmagan bo’lsak
mkdir build
# Build ichiga kirib olamiz
cd build 
```

build ichiga kirib olishimizdan maqsad, cmake hamma generatsion vaqtinchalik axlatlarni build papkasini ichida yaratib tashaydi. Ho’sh, keyin

```bash
# CMake hamma kerakli narsani yaratib olishi uchun
cmake ..
# Kompilyatsiya qilamiz loyihamizni
cmake --build .
# Ishga tushuramiz
./nya
```

Endi esa, gnu/gcc chilarimiz, terminalni loyiha turgan joyidan ochib turib, oddiygina

```bash
make
```

va bo’ldi! Shunday build papkani ochib qarasaylar, nyagcc degan binarnik turibdi, build papkani ichida

```bash
# Qani kefteme
cd build
# Ishga tushurib ko'ramiz
./nyagcc
```

va ishga tushurgach, xoh CMake, xoh GCC, ikkalasi ham

```
Salom Dunyo!
```

degan habar ko’rsatishi kerak. 

Tamom vassalom bugunga. Bu qismni hamma narsani sozlab tayyorlab olish uchun ketqazdim. Bilaman, endi kirib kerganlar hozir betidan ketma-ket tarsaki yeyayotganday his qilishayabdi, lekin keyingi qismlardan hech yoq ozgina bo’lsada (unchamas, ha-ha) osonlashadi. Bugunga esa hammaga hayr!