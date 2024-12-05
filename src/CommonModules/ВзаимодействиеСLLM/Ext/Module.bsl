﻿ #Область ПрограммныйИнтерфейс
Функция ДанныеДляВопроса(АдресСервера, ТекстВопроса, ДополнительныеПараметры = Неопределено) Экспорт
	
	МетодAPI = "/api/generate";
	ТипЗапроса = "POST";
	
	ВопросLLM = Новый Структура;
	ВопросLLM.Вставить("Адрес", АдресСервера + МетодAPI);
	ВопросLLM.Вставить("ТипЗапроса", ТипЗапроса);

	ПараметрыЗапроса = Новый Структура;
	ПараметрыЗапроса.Вставить("model", ДополнительныеПараметры.Модель);
	ПараметрыЗапроса.Вставить("prompt", ТекстВопроса); 
	ПараметрыЗапроса.Вставить("stream", Ложь);
	
	Промт = ЗаписатьЗначениеJSON(ПараметрыЗапроса);
    ВопросLLM.Вставить("Промт", Промт);
	
	Возврат ВопросLLM;

КонецФункции   

Функция ВопросВЧат(АдресСервера, Диалог, ДополнительныеПараметры) Экспорт

	МетодAPI = "/api/chat";
	ТипЗапроса = "POST";
	
	ПараметрыЗапроса = Новый Структура;
	ПараметрыЗапроса.Вставить("model", ДополнительныеПараметры.Модель);
	ПараметрыЗапроса.Вставить("messages", ПривестиДиалогКФормату(Диалог)); 
	ПараметрыЗапроса.Вставить("stream", Ложь);	
	
	Ответ = ОтправитьЗапросСерверу(ТипЗапроса, АдресСервера + МетодAPI, ЗаписатьЗначениеJSON(ПараметрыЗапроса));       

	Возврат ПрочитатьЗначениеJSON(Ответ);
	
КонецФункции

Функция СписокДоступныхМоделей(АдресСервера) Экспорт
	
	ТекМетод = "/api/tags";
	ТипЗапроса = "GET";
	
	ОтветМодели = ОтправитьЗапросСерверу(ТипЗапроса, АдресСервера + ТекМетод, Неопределено);
	
	Модели = ПрочитатьЗначениеJSON(ОтветМодели);
	
	ДоступныеМодели = Новый Массив;
	
	Для каждого ОписаниеМодели из Модели["models"] Цикл
		
		ДоступныеМодели.Добавить(ОписаниеМодели["model"]);
		
	КонецЦикла;             
	
	Возврат ДоступныеМодели;
	
КонецФункции

Функция СвойстваВыбраннойМодели(ИмяМодели, АдресСервера) Экспорт
	
	ТипЗапроса = "POST";
	Путь = "/api/show";
   
    ПараметрыМетода = Новый Структура;
	ПараметрыМетода.Вставить("model", ИмяМодели);

	Ответ = ОтправитьЗапросСерверу(ТипЗапроса, АдресСервера+Путь, ЗаписатьЗначениеJSON(ПараметрыМетода));

	ЧтениеJSON = НОвый ЧтениеJSON;
	ЧтениеJSON.УстановитьСтроку(Ответ);
	ИнформацияМодели = ПрочитатьJSON(ЧтениеJSON, Истина); 
	ЧтениеJSON.Закрыть();   
	
	Возврат ИнформацияМодели;

КонецФункции

Функция УдалитьМодель(ИмяМодели, АдресСервера) Экспорт
	
	ТипЗапроса = "DELETE";
	Путь = "/api/delete";
   
    ПараметрыМетода = Новый Структура;
	ПараметрыМетода.Вставить("model", ИмяМодели);

	Ответ = ОтправитьЗапросСерверу(ТипЗапроса, АдресСервера+Путь, ЗаписатьЗначениеJSON(ПараметрыМетода));


КонецФункции

Функция ДобавитьНовуюМодель(ИмяМодели, АдресСервера, ОтображатьПроцесс = Ложь) Экспорт
	
	ТипЗапроса = "POST";
	Путь = "/api/pull";
   
    ПараметрыМетода = Новый Структура;
	ПараметрыМетода.Вставить("model", ИмяМодели);
   	ПараметрыМетода.Вставить("stream", ОтображатьПроцесс);
	
	Ответ = ОтправитьЗапросСерверу(ТипЗапроса, АдресСервера+Путь, ЗаписатьЗначениеJSON(ПараметрыМетода));

КонецФункции
//{
//  "status": "downloading digestname",
//  "digest": "digestname",
//  "total": 2142590208,
//  "completed": 241970
//}

Функция ОтправитьЗапросСерверу(ТипЗапроса, Адрес, КонтекстРаботы) Экспорт

	Если ТипЗапроса = "GET" Тогда                     
		
		Ответ = GetЗапросКСерверу(Адрес, КонтекстРаботы);
		
	ИначеЕсли ТипЗапроса = "POST" Тогда
		
		Ответ = PostЗапросКСерверу(Адрес, КонтекстРаботы);   
		
	ИначеЕсли ТипЗапроса = "DELETE" Тогда
		
		Ответ = DeleteЗапросКСерверу(Адрес, КонтекстРаботы);		
	Иначе
		ВызватьИсключение "Неподдерживаемый тип запросов";
		
	КонецЕсли;
		
    Возврат  КоннекторHTTP.КакТекст(Ответ, КодировкаТекста.UTF8);

КонецФункции    

Функция РолиЧата() Экспорт

	РолиВЧате = Новый Массив;
    РолиВЧате.Добавить("system");
	РолиВЧате.Добавить("user");
	РолиВЧате.Добавить("assistant");
	РолиВЧате.Добавить("tool");
	
	Возврат РолиВЧате;
	
КонецФункции 

Функция ПривестиДиалогКФормату(Диалог)

	ДиалогМассивом = Новый Массив;
	КлючиСообщения = "role,content";  
	
	Для каждого СообщениеДиалога из Диалог Цикл
		НовоеСообщение = Новый Структура(КлючиСообщения);
		НовоеСообщение["role"]   = СообщениеДиалога.Роль;
		НовоеСообщение["content"] = СообщениеДиалога.Контент; 
		
		ДиалогМассивом.Добавить(НовоеСообщение);	
	КонецЦикла;
	
	Возврат ДиалогМассивом;
	
КонецФункции
#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс
// Код процедур и функций
#КонецОбласти

#Область СлужебныеПроцедурыИФункции
Функция GetЗапросКСерверу(Адрес, Контекст) 
	
	Возврат КоннекторHTTP.Get(Адрес);
	
КонецФункции

Функция PostЗапросКСерверу(Адрес, Контекст)
	
	ПараметрыЗапроса = Новый Структура;
	Заголовки = Новый Соответствие;
	Заголовки.Вставить("Content-Type", "application/json");
	ПараметрыЗапроса.Вставить("Заголовки", Заголовки);
	ПараметрыЗапроса.Вставить("Таймаут", 600);
	
	Возврат КоннекторHTTP.Post(Адрес, Контекст, ПараметрыЗапроса);	
	
КонецФункции 

Функция DeleteЗапросКСерверу(Адрес, КонтекстРаботы)
	
	ПараметрыЗапроса = Новый Структура;
	Заголовки = Новый Соответствие;
	Заголовки.Вставить("Content-Type", "application/json");
	ПараметрыЗапроса.Вставить("Заголовки", Заголовки);
	
	Возврат КоннекторHTTP.Delete(Адрес, КонтекстРаботы, ПараметрыЗапроса);
	
КонецФункции
#КонецОбласти
