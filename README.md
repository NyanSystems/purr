<p align="center">
    <img src="https://raw.githubusercontent.com/NyanSystems/.github/main/pictures/purr/header.gif?sanitize=true"/>
</p>

<h2 align="center">Purr</h2>

<div align="center">
    <a href="https://github.com/orgs/NyanSystems/repositories">
        <img src="https://img.shields.io/static/v1.svg?style=rounded-square&label=Type&message=Documentation&logo=4chan&logoColor=311ac5&colorA=ead186&colorB=fe77ff"/>
    </a> 
    <a href="https://github.com/NyanSystems/nya/blob/main/flake.nix">
        <img src="https://img.shields.io/static/v1.svg?style=rounded-square&label=Target&message=Web&logo=nixos&logoColor=311ac5&colorA=ead186&colorB=fe77ff"/>
    </a>
</div>

<p align="center">Infrastrukturalar yaratish jarayonida ulashgan tajribalarimiz.</p>


Purr bu statik generatsiya qilingan dokumentatsiyamiz. Biz shu loyiha o'zi umumman boshlagan paytimizdan yozib borgan hamma tajribayu qadamlarimizni shu dokumentatsiya ko'rinishidagi blog websayt da ulashib boramiz. 

## Boshlash

### O'rnatish

Unday qiyin emas bu saytni localhost da ishga tushurish. Uning uchun, siz [Zola](https://www.getzola.org) ni o'rnatib olishingiz kerak bo'ladi.

Agar sizda Nix paket menejeri o'rnatilgan bo'lsa, undanda yaxshi! Purr da shell.nix mavjud va terminalda:

```shell
# shell.nix ishlatadi
nix-shell
```

ishga tushishi bilan avtomatik server ham [localhost:1111](http://127.0.0.1:1111/) portida ishga tushuriladi terminal sessiyada va terminal sessiya yopilishi bilan server ham yopiladi.

### Ishlash

Kiritilgan o'zgarishlarni websaytda ko'rish uchun, terminalni ochib, loyiha turgan joyidan ushbu buyruq ishga tushurasiz:

```shell
zola --serve
```

Yoki sizda nix paket menejeri o'rnatilgan bo'lsa, shu oddiygina nix shell ishga tushurasiz, o'zi serverni ishga tushurib, kerakli narsalarni terminalga osib beradi:

```shell
# shell.nix ishlatadi
nix-shell
```

### Hissa qo'shish

Hamma postlarimiz `content` nomli papkani ichida joylashtirilgan va ushbu fayldagi kontentlarni o'zgartirishingiz mumkin. `contnet` papkasi ichidagi fayllardan boshqa narsaga qilingan o'zgarishlar uchun jo'natilgan PR avtomatik tarzda qabul qilinmaydi. Unday holatda [issue](https://github.com/NyanSystems/purr/issues/new) ochishingizga to'g'ri keladi. 

<p align="center"><img src="https://raw.githubusercontent.com/NyanSystems/.github/main/pictures/etc/footer.svg?sanitize=true" /></p>

<p align="center">Barcha huquqlar himoyalangan &copy; 2024 Nyan Systems Developers</p>

<p align="center"><a href="https://github.com/NyanSystems/nya/blob/main/LICENSE"><img src="https://img.shields.io/badge/License-MIT-fe77ff.svg"/></a></p>

[Nyan Systems Inc.]: https://github.com/NyanSystems