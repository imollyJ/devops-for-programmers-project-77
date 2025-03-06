### Hexlet tests and linter status:
[![Actions Status](https://github.com/imollyJ/devops-for-programmers-project-77/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/imollyJ/devops-for-programmers-project-77/actions)
### Upmon status
![Upmon Status](https://www.upmon.com/badge/caad6e8d-eb33-4ead-922b-d117df/GxLT8YrK/check.svg)

# **Развёртывание инфраструктуры и приложения Ghost на Yandex Cloud**

## **Системные требования**
Для работы необходима ОС **Ubuntu (Linux)** и установленные утилиты:

- **Ansible** → версия **2.16.1**  
- **GNU Make** → версия **4.3**  
- **Terraform** → версия **1.7.3**  

## **Настройка инфраструктуры в Yandex Cloud**

### **1 Подготовка Yandex Cloud**  
1. Зарегистрируйтесь в **Yandex Cloud**.  
2. Создайте **проект** и **рабочее пространство** для хранения состояния инфраструктуры.  
3. Укажите их в файле `backend.tf`.  

### **2  Настройка переменных**  
Создайте файл **`terraform/secret.auto.tfvars`** и добавьте в него:

```ini
yc_token        = "<oAuth-токен Yandex Cloud>"
yc_cloud_id     = "<ID облака Yandex Cloud>"
yc_folder_id    = "<ID каталога Yandex Cloud>"
db_name         = "<Имя базы данных>"
db_user         = "<Пользователь БД>"
db_password     = "<Пароль пользователя БД>"
domain          = "<Домен для приложения>"
datadog_api_key = "<API-ключ Datadog>"
datadog_app_key = "<Ключ приложения Datadog>"
```

### **3  Инициализация Terraform**  
Перед первым запуском выполните:  
```sh
make tf-init
```

### **4  Развёртывание инфраструктуры**  
Запустите создание облачной инфраструктуры:  
```sh
make tf-apply
```

### **5  Удаление инфраструктуры**  
Если нужно удалить созданные ресурсы:  
```sh
make tf-destroy
```

### **🔹 Вспомогательные команды**  
- **Переинициализация Terraform** → `make tf-reconfigure`  
- **Проверка конфигурации** → `make tf-validate`  
- **Форматирование файлов** → `make tf-format`  

---

## **Развёртывание Ghost (5.79.3) и Datadog Agent (4.22.0)**  

### **1 Настройка переменных Ansible**  
#### 🔹 **Зашифрованные переменные (`vault.yml`)**  
Добавьте их в `ansible/group_vars/all/vault.yml` и зашифруйте файл:  
```yaml
DB_CLIENT: "mysql"  # (Поддержка PostgreSQL в разработке)
DB_HOST: "<Хост базы данных>"
DB_NAME: "<Имя базы данных>"
DB_USER: "<Пользователь базы данных>"
DB_PASSWORD: "<Пароль пользователя БД>"
DATADOG_KEY: "<API-ключ Datadog>"
```

#### 🔹 **Открытые переменные (`vars.yml`)**  
Запишите их в `ansible/group_vars/all/vars.yml`:  
```yaml
GHOST_PORT: "<Порт для Ghost>"
GHOST_URL: "<Домен или localhost>"
```

### **2  Деплой приложения**  
Запуск развёртывания:  
```sh
make deploy
```

## **🔗 Доступ к приложению**  
После успешного деплоя приложение будет доступно по адресу:  
👉 **`<www.mollyj.ru>`**  

---


