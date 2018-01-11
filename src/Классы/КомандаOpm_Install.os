///////////////////////////////////////////////////////////////////////////////////////////////////
// Прикладной интерфейс

Процедура ЗарегистрироватьКоманду(Знач ИмяКоманды, Знач Парсер) Экспорт
	
	ОписаниеКоманды = Парсер.ОписаниеКоманды(ИмяКоманды, "Выполнить установку. Если указано имя пакета, происходит установка из хаба или из файла. В обратном случае устанавливаются зависимости текущего пакета по файлу packagedef.");
	Парсер.ДобавитьПараметрФлагКоманды(ОписаниеКоманды, "-all", "Установить все пакеты, зарегистрированные в хабе");
	Парсер.ДобавитьИменованныйПараметрКоманды(ОписаниеКоманды, "-f", "Указать файл из которого нужно установить пакет");
	Парсер.ДобавитьПараметрФлагКоманды(ОписаниеКоманды, "-l", "Установить пакеты в локальный каталог oscript_modules");
	Парсер.ДобавитьИменованныйПараметрКоманды(ОписаниеКоманды, "-dest", "Переопределить стандартный каталог в который устанавливаются пакеты (вместо oscript_modules)");
	Парсер.ДобавитьПозиционныйПараметрКоманды(ОписаниеКоманды, "ИмяПакета", "Имя пакета в хабе. Чтобы установить конкретную версию, используйте ИмяПакета@ВерсияПакета");
	Парсер.ДобавитьКоманду(ОписаниеКоманды);

КонецПроцедуры

// Выполняет логику команды
// 
// Параметры:
//   ПараметрыКоманды - Соответствие ключей командной строки и их значений
//
Функция ВыполнитьКоманду(Знач ПараметрыКоманды) Экспорт
	УстановитьПакет(ПараметрыКоманды);
	Возврат 0;
КонецФункции

Процедура УстановитьПакет(Знач ЗначенияПараметров) Экспорт
	
	Установщик = Новый УстановкаПакета;
	
	Если ЗначенияПараметров["-l"] Тогда
		Если ЗначениеЗаполнено(ЗначенияПараметров["-dest"]) Тогда
			Лог = Логирование.ПолучитьЛог(ПараметрыСистемыOpm.ИмяЛогаСистемы());
			Лог.Предупреждение("При локальной установке параметр -dest игнорируется");
		КонецЕсли;
		Установщик.УстановитьРежимУстановкиПакетов(РежимУстановкиПакетов.Локально);
	Иначе
		Установщик.УстановитьРежимУстановкиПакетов(РежимУстановкиПакетов.Глобально);

		Если ЗначениеЗаполнено(ЗначенияПараметров["-dest"]) Тогда
			Установщик.УстановитьЦелевойКаталог(ЗначенияПараметров["-dest"]);
		КонецЕсли;

	КонецЕсли;
	
	Если ЗначенияПараметров["-all"] Тогда
		Установщик.УстановитьВсеПакетыИзОблака();
	ИначеЕсли ЗначенияПараметров["-f"] = Неопределено И ЗначенияПараметров["ИмяПакета"] = Неопределено Тогда
		Установщик.УстановитьПакетыПоОписаниюПакета();
	ИначеЕсли ЗначенияПараметров["-f"] <> Неопределено Тогда
		Установщик.УстановитьПакетИзАрхива(ЗначенияПараметров["-f"]);
	Иначе
		Установщик.УстановитьПакетИзОблака(ЗначенияПараметров["ИмяПакета"]);
	КонецЕсли;
	
КонецПроцедуры
