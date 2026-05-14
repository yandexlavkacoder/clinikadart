import '../data/database.dart';
import '../data/repositories/clinic_repositories.dart';
import '../domain/models/models.dart';
import 'input_helper.dart';

class Menu {
  final ClinicDatabase database = ClinicDatabase();
  final InputHelper input = InputHelper();

  late final PatientRepository patientRepository;
  late final PositionRepository positionRepository;
  late final DoctorRepository doctorRepository;
  late final AppointmentRepository appointmentRepository;
  late final MedicalCardRepository medicalCardRepository;
  late final ServiceRepository serviceRepository;
  late final PaymentRepository paymentRepository;
  late final DoctorScheduleRepository doctorScheduleRepository;

  Menu() {
    patientRepository = PatientRepository(database.db);
    positionRepository = PositionRepository(database.db);
    doctorRepository = DoctorRepository(database.db);
    appointmentRepository = AppointmentRepository(database.db);
    medicalCardRepository = MedicalCardRepository(database.db);
    serviceRepository = ServiceRepository(database.db);
    paymentRepository = PaymentRepository(database.db);
    doctorScheduleRepository = DoctorScheduleRepository(database.db);
  }

  void run() {
    while (true) {
      print('\nCLI-система "Клиника"');
      print('1. Пациенты');
      print('2. Должности');
      print('3. Врачи');
      print('4. Записи на приём');
      print('5. Медицинские карты');
      print('6. Услуги');
      print('7. Оплаты');
      print('8. Расписание врачей');
      print('9. Показать всё из БД');
      print('0. Выход');

      final choice = input.askString('Выберите пункт: ');

      switch (choice) {
        case '1':
          patientMenu();
          break;
        case '2':
          positionMenu();
          break;
        case '3':
          doctorMenu();
          break;
        case '4':
          appointmentMenu();
          break;
        case '5':
          medicalCardMenu();
          break;
        case '6':
          serviceMenu();
          break;
        case '7':
          paymentMenu();
          break;
        case '8':
          doctorScheduleMenu();
          break;
        case '9':
          showAllDatabase();
          break;
        case '0':
          database.close();
          print('Программа завершена.');
          return;
        default:
          print('Неверный пункт меню.');
      }
    }
  }

  void printCrudMenu(String title) {
    print('\n$title');
    print('1. Добавить');
    print('2. Показать все');
    print('3. Обновить');
    print('4. Удалить');
    print('0. Назад');
  }

  void patientMenu() {
    while (true) {
      printCrudMenu('Пациенты');
      final choice = input.askString('Выберите пункт: ');

      switch (choice) {
        case '1':
          final patient = Patient(
            fullName: input.askString('ФИО пациента: '),
            phone: input.askString('Телефон: '),
            birthDate: input.askDate('Дата рождения YYYY-MM-DD: '),
          );
          patientRepository.create(patient);
          print('Пациент добавлен.');
          break;
        case '2':
          patientRepository.readAll().forEach(print);
          break;
        case '3':
          final id = input.askInt('ID пациента: ');
          final patient = Patient(
            id: id,
            fullName: input.askString('Новое ФИО: '),
            phone: input.askString('Новый телефон: '),
            birthDate: input.askDate('Новая дата рождения YYYY-MM-DD: '),
          );
          patientRepository.update(patient);
          print('Пациент обновлён.');
          break;
        case '4':
          patientRepository.delete(input.askInt('ID пациента: '));
          print('Пациент удалён.');
          break;
        case '0':
          return;
      }
    }
  }

  void positionMenu() {
    while (true) {
      printCrudMenu('Должности');
      final choice = input.askString('Выберите пункт: ');

      switch (choice) {
        case '1':
          positionRepository.create(Position(
            title: input.askString('Название должности: '),
            salary: input.askDouble('Зарплата: '),
          ));
          print('Должность добавлена.');
          break;
        case '2':
          positionRepository.readAll().forEach(print);
          break;
        case '3':
          positionRepository.update(Position(
            id: input.askInt('ID должности: '),
            title: input.askString('Новое название: '),
            salary: input.askDouble('Новая зарплата: '),
          ));
          print('Должность обновлена.');
          break;
        case '4':
          positionRepository.delete(input.askInt('ID должности: '));
          print('Должность удалена.');
          break;
        case '0':
          return;
      }
    }
  }

  void doctorMenu() {
    while (true) {
      printCrudMenu('Врачи');
      final choice = input.askString('Выберите пункт: ');

      switch (choice) {
        case '1':
          doctorRepository.create(Doctor(
            fullName: input.askString('ФИО врача: '),
            phone: input.askString('Телефон: '),
            positionId: input.askInt('ID должности: '),
          ));
          print('Врач добавлен.');
          break;
        case '2':
          doctorRepository.readAll().forEach(print);
          break;
        case '3':
          doctorRepository.update(Doctor(
            id: input.askInt('ID врача: '),
            fullName: input.askString('Новое ФИО: '),
            phone: input.askString('Новый телефон: '),
            positionId: input.askInt('Новый ID должности: '),
          ));
          print('Врач обновлён.');
          break;
        case '4':
          doctorRepository.delete(input.askInt('ID врача: '));
          print('Врач удалён.');
          break;
        case '0':
          return;
      }
    }
  }

  void appointmentMenu() {
    while (true) {
      printCrudMenu('Записи на приём');
      final choice = input.askString('Выберите пункт: ');

      switch (choice) {
        case '1':
          appointmentRepository.create(Appointment(
            patientId: input.askInt('ID пациента: '),
            doctorId: input.askInt('ID врача: '),
            appointmentDate: input.askDate('Дата приёма YYYY-MM-DD: '),
            reason: input.askString('Причина обращения: '),
          ));
          print('Запись добавлена.');
          break;
        case '2':
          appointmentRepository.readAll().forEach(print);
          break;
        case '3':
          appointmentRepository.update(Appointment(
            id: input.askInt('ID записи: '),
            patientId: input.askInt('Новый ID пациента: '),
            doctorId: input.askInt('Новый ID врача: '),
            appointmentDate: input.askDate('Новая дата YYYY-MM-DD: '),
            reason: input.askString('Новая причина: '),
          ));
          print('Запись обновлена.');
          break;
        case '4':
          appointmentRepository.delete(input.askInt('ID записи: '));
          print('Запись удалена.');
          break;
        case '0':
          return;
      }
    }
  }

  void medicalCardMenu() {
    while (true) {
      printCrudMenu('Медицинские карты');
      final choice = input.askString('Выберите пункт: ');

      switch (choice) {
        case '1':
          medicalCardRepository.create(MedicalCard(
            patientId: input.askInt('ID пациента: '),
            doctorId: input.askInt('ID врача: '),
            diagnosis: input.askString('Диагноз: '),
            treatment: input.askString('Лечение: '),
          ));
          print('Медицинская карта добавлена.');
          break;
        case '2':
          medicalCardRepository.readAll().forEach(print);
          break;
        case '3':
          medicalCardRepository.update(MedicalCard(
            id: input.askInt('ID карты: '),
            patientId: input.askInt('Новый ID пациента: '),
            doctorId: input.askInt('Новый ID врача: '),
            diagnosis: input.askString('Новый диагноз: '),
            treatment: input.askString('Новое лечение: '),
          ));
          print('Медицинская карта обновлена.');
          break;
        case '4':
          medicalCardRepository.delete(input.askInt('ID карты: '));
          print('Медицинская карта удалена.');
          break;
        case '0':
          return;
      }
    }
  }

  void serviceMenu() {
    while (true) {
      printCrudMenu('Услуги');
      final choice = input.askString('Выберите пункт: ');

      switch (choice) {
        case '1':
          serviceRepository.create(Service(
            name: input.askString('Название услуги: '),
            price: input.askDouble('Цена: '),
          ));
          print('Услуга добавлена.');
          break;
        case '2':
          serviceRepository.readAll().forEach(print);
          break;
        case '3':
          serviceRepository.update(Service(
            id: input.askInt('ID услуги: '),
            name: input.askString('Новое название: '),
            price: input.askDouble('Новая цена: '),
          ));
          print('Услуга обновлена.');
          break;
        case '4':
          serviceRepository.delete(input.askInt('ID услуги: '));
          print('Услуга удалена.');
          break;
        case '0':
          return;
      }
    }
  }

  void paymentMenu() {
    while (true) {
      printCrudMenu('Оплаты');
      final choice = input.askString('Выберите пункт: ');

      switch (choice) {
        case '1':
          paymentRepository.create(Payment(
            appointmentId: input.askInt('ID записи на приём: '),
            serviceId: input.askInt('ID услуги: '),
            amount: input.askDouble('Сумма оплаты: '),
            paymentDate: input.askDate('Дата оплаты YYYY-MM-DD: '),
          ));
          print('Оплата добавлена.');
          break;
        case '2':
          paymentRepository.readAll().forEach(print);
          break;
        case '3':
          paymentRepository.update(Payment(
            id: input.askInt('ID оплаты: '),
            appointmentId: input.askInt('Новый ID записи: '),
            serviceId: input.askInt('Новый ID услуги: '),
            amount: input.askDouble('Новая сумма: '),
            paymentDate: input.askDate('Новая дата YYYY-MM-DD: '),
          ));
          print('Оплата обновлена.');
          break;
        case '4':
          paymentRepository.delete(input.askInt('ID оплаты: '));
          print('Оплата удалена.');
          break;
        case '0':
          return;
      }
    }
  }

  void doctorScheduleMenu() {
    while (true) {
      printCrudMenu('Расписание врачей');
      final choice = input.askString('Выберите пункт: ');

      switch (choice) {
        case '1':
          doctorScheduleRepository.create(DoctorSchedule(
            doctorId: input.askInt('ID врача: '),
            workDate: input.askDate('Дата работы YYYY-MM-DD: '),
            startTime: input.askString('Начало работы HH:MM: '),
            endTime: input.askString('Конец работы HH:MM: '),
          ));
          print('Расписание добавлено.');
          break;
        case '2':
          doctorScheduleRepository.readAll().forEach(print);
          break;
        case '3':
          doctorScheduleRepository.update(DoctorSchedule(
            id: input.askInt('ID расписания: '),
            doctorId: input.askInt('Новый ID врача: '),
            workDate: input.askDate('Новая дата YYYY-MM-DD: '),
            startTime: input.askString('Новое начало HH:MM: '),
            endTime: input.askString('Новый конец HH:MM: '),
          ));
          print('Расписание обновлено.');
          break;
        case '4':
          doctorScheduleRepository.delete(input.askInt('ID расписания: '));
          print('Расписание удалено.');
          break;
        case '0':
          return;
      }
    }
  }

  void showAllDatabase() {
    print('\nВсё из БД');

    print('\nПациенты');
    patientRepository.readAll().forEach(print);

    print('\nДолжности');
    positionRepository.readAll().forEach(print);

    print('\nВрачи');
    doctorRepository.readAll().forEach(print);

    print('\nЗаписи на приём');
    appointmentRepository.readAll().forEach(print);

    print('\nМедицинские карты');
    medicalCardRepository.readAll().forEach(print);

    print('\nУслуги');
    serviceRepository.readAll().forEach(print);

    print('\nОплаты');
    paymentRepository.readAll().forEach(print);

    print('\nРасписание врачей');
    doctorScheduleRepository.readAll().forEach(print);
  }
}
