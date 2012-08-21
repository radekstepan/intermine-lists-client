Chaplin = require 'chaplin'

# Objects in the list (genes, proteins and what have yous).
module.exports = class ListObjectCollection extends Chaplin.Collection

    # Our custom constructor.
    constructor: ->
        # Backbone.js
        @_reset()
        @initialize.apply this, arguments

        # Our stuff.
        for row in @data
            @push row

    data: [
        {
            "id": 1,
            "age": 35,
            "admin": true,
            "name": "Дмитрий Фролов",
            "company": "Generola",
            "email": "dmitriy@generola.com",
            "registerDate": "Wed, 24 Mar 1982 04:30:41 GMT"
        },
        {
            "id": 2,
            "age": -16,
            "admin": false,
            "name": "Мартын Гусев",
            "company": "Conrama",
            "email": "martyn@conrama.com",
            "registerDate": "Mon, 23 Aug 1993 07:32:42 GMT"
        },
        {
            "id": 3,
            "age": -16,
            "admin": true,
            "name": "Егор Мальцев",
            "company": "Teratopia",
            "email": "egor@teratopia.com",
            "registerDate": "Sun, 25 Jan 2004 17:32:27 GMT"
        },
        {
            "id": 4,
            "age": -3,
            "admin": true,
            "name": "Павел Степанов",
            "company": "Conotomics",
            "email": "pavel@conotomics.com",
            "registerDate": "Mon, 02 Jan 1978 22:45:09 GMT"
        },
        {
            "id": 5,
            "age": 60,
            "admin": false,
            "name": "Адам Иванов",
            "company": "Systheon",
            "email": "adam@systheon.com",
            "registerDate": "Thu, 26 Nov 1992 20:49:33 GMT"
        },
        {
            "id": 6,
            "age": 39,
            "admin": true,
            "name": "Андрей Петров",
            "company": "RoboAerlogix",
            "email": "andrey@roboaerlogix.com",
            "registerDate": "Thu, 26 Apr 1990 23:34:24 GMT"
        },
        {
            "id": 7,
            "age": 29,
            "admin": false,
            "name": "Гарри Морозов",
            "company": "Superscope",
            "email": "garri@superscope.com",
            "registerDate": "Sat, 26 Mar 1983 10:58:50 GMT"
        },
        {
            "id": 8,
            "age": 45,
            "admin": false,
            "name": "Станислав Тарасов",
            "company": "Anaframe",
            "email": "stanislav@anaframe.com",
            "registerDate": "Mon, 04 Feb 1985 15:49:57 GMT"
        },
        {
            "id": 9,
            "age": -3,
            "admin": true,
            "name": "Клемент Романов",
            "company": "Openserve",
            "email": "klement@openserve.com",
            "registerDate": "Sun, 31 Mar 1985 02:48:54 GMT"
        },
        {
            "id": 10,
            "age": -16,
            "admin": false,
            "name": "Семен Козлов",
            "company": "Ventanium",
            "email": "semen@ventanium.com",
            "registerDate": "Tue, 28 Feb 1978 00:01:20 GMT"
        },
        {
            "id": 11,
            "age": 27,
            "admin": true,
            "name": "Гарри Морозов",
            "company": "Superscope",
            "email": "garri@superscope.com",
            "registerDate": "Mon, 09 Dec 1996 23:58:42 GMT"
        },
        {
            "id": 12,
            "age": 10,
            "admin": true,
            "name": "Владислав Бабич",
            "company": "Jamrola",
            "email": "vladislav@jamrola.com",
            "registerDate": "Mon, 30 Aug 1971 07:05:21 GMT"
        },
        {
            "id": 13,
            "age": 20,
            "admin": false,
            "name": "Донат Михайлов",
            "company": "Compuamerica",
            "email": "donat@compuamerica.com",
            "registerDate": "Wed, 18 Apr 1973 20:33:25 GMT"
        },
        {
            "id": 14,
            "age": -7,
            "admin": true,
            "name": "Парамон Белов",
            "company": "Qualserve",
            "email": "paramon@qualserve.com",
            "registerDate": "Fri, 22 Oct 1982 14:52:09 GMT"
        },
        {
            "id": 15,
            "age": 36,
            "admin": true,
            "name": "Руслан Борисов",
            "company": "iMedconik",
            "email": "ruslan@imedconik.com",
            "registerDate": "Sun, 17 Dec 2000 17:48:40 GMT"
        },
        {
            "id": 16,
            "age": 36,
            "admin": true,
            "name": "Глеб Захаров",
            "company": "Ameritron",
            "email": "gleb@ameritron.com",
            "registerDate": "Tue, 14 Sep 2004 08:23:12 GMT"
        },
        {
            "id": 17,
            "age": 30,
            "admin": false,
            "name": "Юрий Титов",
            "company": "Fibroserve",
            "email": "yuriy@fibroserve.com",
            "registerDate": "Wed, 23 Nov 2005 21:19:23 GMT"
        },
        {
            "id": 18,
            "age": -17,
            "admin": false,
            "name": "Роман Чернов",
            "company": "Fibrotopia",
            "email": "roman@fibrotopia.com",
            "registerDate": "Mon, 10 Sep 2007 18:16:18 GMT"
        },
        {
            "id": 19,
            "age": 44,
            "admin": true,
            "name": "Роман Чернов",
            "company": "Fibrotopia",
            "email": "roman@fibrotopia.com",
            "registerDate": "Tue, 08 Feb 1983 03:14:35 GMT"
        },
        {
            "id": 20,
            "age": 35,
            "admin": false,
            "name": "Виктор Рубан",
            "company": "Teraserv",
            "email": "viktor@teraserv.com",
            "registerDate": "Wed, 23 Jan 2008 05:03:06 GMT"
        }
    ]