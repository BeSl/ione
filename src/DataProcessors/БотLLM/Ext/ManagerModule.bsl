Функция МетодыLLMСервера() Экспорт
	
	ВсеМетоды = Новый Массив;
	МетодОтвет = Новый_МетодСервера();
	МетодОтвет.Наименование = "Генерация ответа";
	МетодОтвет.ТипЗапроса = "POST";
	МетодОтвет.Путь = "/api/generate";
	Парам = Новый_ПараметрМетода();
	Парам.ИмяПараметра = "model";
	МетодОтвет.Параметры.Добавить(Парам);
	Парам = Новый_ПараметрМетода();
	Парам.ИмяПараметра = "prompt";
	МетодОтвет.Параметры.Добавить(Парам);   
	Парам = Новый_ПараметрМетода();
	Парам.ИмяПараметра = "suffix";
	МетодОтвет.Параметры.Добавить(Парам);
	Парам = Новый_ПараметрМетода();
	Парам.ИмяПараметра = "images";
	МетодОтвет.Параметры.Добавить(Парам);
    ВсеМетоды.Добавить(МетодОтвет);
	МетодЧат = Новый_МетодСервера();
	МетодЧат.Наименование = "Режим чата";
	МетодЧат.ТипЗапроса = "POST";
	МетодЧат.Путь = "/api/chat";
	
	Парам = Новый_ПараметрМетода();
	Парам.ИмяПараметра = "model";
	МетодЧат.Параметры.Добавить(Парам);	
	
	Парам = Новый_ПараметрМетода();
	Парам.ИмяПараметра = "messages";
	МетодЧат.Параметры.Добавить(Парам);
	
	Парам = Новый_ПараметрМетода();
	Парам.ИмяПараметра = "tools";
	МетодЧат.Параметры.Добавить(Парам);
	 ВсеМетоды.Добавить(МетодЧат);

	//Отключение потоковой передачи
	//"stream": false
	
//	The message object has the following fields:

//role: the role of the message, either system, user, assistant, or tool
//content: the content of the message
//images (optional): a list of images to include in the message (for multimodal models such as llava)
//tool_calls (optional): a list of tools the model wants to use

//format: the format to return a response in. Currently the only accepted value is json
//options: additional model parameters listed in the documentation for the Modelfile such as temperature
//stream: if false the response will be returned as a single response object, rather than a stream of objects
//keep_alive: controls how long the model will stay loaded into memory following the request (default: 5m)
 	Метод = Новый_МетодСервера();
	Метод.Наименование = "Список моделей";
	Метод.ТипЗапроса = "GET";
	Метод.Путь = "/api/tags";

    ВсеМетоды.Добавить(Метод);
 	Метод = Новый_МетодСервера();
	Метод.Наименование = "Информация по моделям";
	Метод.ТипЗапроса = "POST";
	Метод.Путь = "/api/show";
     ВсеМетоды.Добавить(Метод);

	Парам = Новый_ПараметрМетода();
	Парам.ИмяПараметра = "model";   
	Парам.Обязательный = Истина;
	Метод.Параметры.Добавить(Парам);
 	Парам = Новый_ПараметрМетода();
	Парам.ИмяПараметра = "verbose";
	Метод.Параметры.Добавить(Парам);
	  ВсеМетоды.Добавить(Метод);

	  Возврат ВсеМетоды;
//	выбрать модель
//	POST /api/pull
//	
//	создать ембединг
//	POST /api/embed
//	
//	model: name of model to generate embeddings from
//input: text or list of text to generate embeddings for
//	    Advanced parameters:
//	truncate: truncates the end of each input to fit within context length. Returns error if false and context length is exceeded. Defaults to true
//options: additional model parameters listed in the documentation for the Modelfile such as temperature
//keep_alive: controls how long the model will stay loaded into memory following the request (default: 5m)
КонецФункции


Функция Новый_МетодСервера()
	
	Метод = Новый Структура;
	Метод.Вставить("ТипЗапроса",);
	Метод.Вставить("Путь",);
	Метод.Вставить("Наименование",); 
	Метод.Вставить("Описание",);
	Метод.Вставить("Параметры", Новый Массив);
	
	Возврат Метод;
	
	
КонецФункции

Функция Новый_ПараметрМетода()
	
	Возврат Новый Структура("ИмяПараметра,Обязательный",,Ложь);	
	
КонецФункции