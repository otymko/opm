///////////////////////////////////////////////////////////////////////////////////////////////////
// Прикладной интерфейс

Процедура ОписаниеКоманды(Знач КомандаПриложения) Экспорт
	
	// КомандаПриложения.Опция("f full-version", Ложь, "Вывод полного описания версии");

КонецПроцедуры

// Выполняет логику команды
// 
// Параметры:
//   ПараметрыКоманды - Соответствие ключей командной строки и их значений
//
Процедура ВыполнитьКоманду(Знач КомандаПриложения) Экспорт
	Сообщить(КонстантыOpm.ВерсияПродукта);
КонецПроцедуры