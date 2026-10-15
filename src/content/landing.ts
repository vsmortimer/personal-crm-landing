// Landing copy for "Личная CRM". Source: the approved text (my landing text.md) via design/src/content/landing.ts.
// Edit copy only here; components take every string from this file.

// Set PUBLIC_APP_URL at build time to point the buttons elsewhere
export const APP_URL = import.meta.env.PUBLIC_APP_URL || "https://app.example-crm.site";

export const meta = {
  title: "Личная CRM — люди, которых вы знаете лично",
  description:
    "Записная книжка для знакомых: кто это, откуда вы знакомы, как связаться и о чём договорились.",
};

export const brand = { name: "Личная CRM", tagline: "для своих", year: "2026" };

export const cta = "Открыть приложение";

export const hero = {
  // accentWord is rendered in italics in the accent color
  title: { before: "Не теряйте людей, которых знаете ", accentWord: "лично", after: "" },
  subtitle:
    "Кто это, откуда вы знакомы, как связаться и о чём договорились — всё в одной карточке. Не для продаж, а для своих.",
  // Illustration of a contact card (made-up data for the visual, not a product promise)
  exampleCard: {
    ariaLabel: "Пример карточки контакта",
    initials: "АК",
    name: "Андрей Ковалёв",
    who: "Делал ремонт кухни",
    howWeMetLabel: "Откуда знакомы",
    howWeMet: "Через Лену, на её новоселье",
    noteDate: "12 октября",
    note: "Созвониться после праздников, обсудить ванную",
  },
};

export const familiar = {
  number: "01",
  title: "Знакомо?",
  items: [
    { text: "Познакомились на конференции, а через полгода не помните ни имени, ни где виделись" },
    { text: "Договорились созвониться «после праздников» — и забыли, о чём именно" },
    // accent: fragment rendered in italics in the accent color
    { before: "В телефоне записано ", accent: "«Андрей ремонт»", after: ", а какой Андрей и какой ремонт — уже загадка" },
  ],
};

export const howItWorks = {
  number: "02",
  title: "Как это работает",
  steps: [
    { title: "Откройте", text: "Все ваши люди сразу видны одним списком" },
    { title: "Добавьте человека", text: "Имя, кто он, откуда вы знакомы, телефон и почта" },
    {
      title: "Найдите и допишите",
      text: "Начните вводить имя, откройте карточку и запишите, о чём поговорили. Заметка сохранится с датой",
    },
  ],
};

export const cardFields = {
  number: "03",
  title: "Что хранится в карточке",
  fields: [
    { label: "Кто это", text: "Чем занимается, кем вам приходится" },
    { label: "Откуда знакомы", text: "Где встретились, кто познакомил" },
    { label: "Телефон и почта", text: "" },
    { label: "Заметки после разговоров", text: "Каждая с датой, вся история общения в одном месте" },
  ],
};

export const why = {
  number: "04",
  // Non-breaking space between "в" and "телефоне", as in the design
  title: "Почему не просто контакты в телефоне",
  items: [
    { title: "Не для продаж", text: "Никаких сделок, воронок и планов — только люди и разговоры с ними" },
    { title: "Помнит контекст", text: "В телефоне — номер, здесь — кто человек и о чём вы договорились" },
    { title: "Открывается в браузере", text: "Тот же адрес на другом компьютере — те же контакты" },
  ],
};

export const final = {
  title: { before: "Начните с ", accentWord: "одного", after: " человека" },
  text: "Вспомните, с кем говорили на этой неделе, и запишите, о чём договорились. Это займёт минуту.",
};
