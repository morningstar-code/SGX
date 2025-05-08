let PlayerName = "";
let Accounts = [];
let SelectedAccount = null;
let transactionsList = [];

async function Wait(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

function Random(min, max) {
  return Math.floor(Math.random() * (max - min)) + min;
}

async function LoadBankingMenu() {
  $(".wrapper").css("display", "none");
  $(".loadingscreen").removeAttr("style");

  for (let i = 1; i < $(".loadingscreen-progress-cell").length + 1; i++) {
    $(`.loadingscreen-progress-cell:nth-child(${i})`).css(
      "background",
      "#868686"
    );

    await Wait(Random(1, 150));
  }

  $(".loadingscreen").fadeOut(500);
  $(".wrapper").fadeIn(500);

  $(".loadingscreen-progress-cell").removeAttr("style");

  return;
}

function ShowModal(type) {
  let modalClass = null;

  $(".modal").css("display", "none");

  switch (type) {
    case "create-account":
      modalClass = ".modal-createaccount";
      break;

    case "deposit":
      modalClass = ".modal-deposit";
      break;

    case "withdraw":
      modalClass = ".modal-withdraw";
      break;

    case "transfer":
      modalClass = ".modal-transfer";
      break;

    case "deleteaccount":
      modalClass = ".modal-deleteaccount";
      break;

    default:
      break;
  }

  if (modalClass) {
    $(".screen-fade").fadeIn(400);

    $(`${modalClass} .account-details-user-accountname`).text(
      SelectedAccount?.name
    );

    $(`${modalClass}`).attr("data-accountid", SelectedAccount?.id);

    $(modalClass).fadeIn(400);
  } else $(".screen-fade").fadeOut(400);
}

function PushTransactions(transactions) {
  $(".selected-account-transactions").children().remove();

  if (transactions?.length == 0) {

    return;
  }

  transactions = transactions.reverse();
  for (let i = 0; i < transactions.length; i++) {
    let transaction = transactions[i];

    let transactionTypeImage = null;
    switch (transaction.type) {
      case "deposit":
        transactionTypeImage = "images/money-deposit.svg";
        break;
      case "withdraw":
        transactionTypeImage = "images/money-withdraw.svg";
        break;
      case "transfer_sent":
        transactionTypeImage = "images/money-transfer.svg";
      case "transfer_recieved":
        transactionTypeImage = "images/money-transfer.svg";
        break;
      default:
        transactionTypeImage = "images/money.svg";
        break;
    }
  }
}

function GetAccount(accountId) {
  let targetAccount = null;

  for (let i = 0; i < Accounts.length; i++) {
    if (Accounts[i].id == accountId) {
      targetAccount = Accounts[i];
      break;
    }
  }

  return targetAccount;
}

function LoadAccounts() {


  for (let i = 0; i < Accounts.length; i++) {
    let account = Accounts[i];

    
  }



}

function SelectAccount(accountId) {
  if (accountId == SelectedAccount?.id && accountId) return;

  $(".account-details-selected").removeClass("account-details-selected");

  let account = GetAccount(accountId);

  if (!account) {
    $(".selected-account").css("visibility", "hidden");
    $(".selected-account-transactions").children().remove();
    return;
  } else {
    $(".selected-account").removeAttr("style");
  }

  SelectedAccount = account;

  $("#selected-account-owner").text(PlayerName);
  $("#selected-account-name").text(SelectedAccount.name);

  $("#selected-account-id").text(SelectedAccount.id);

  $(`.account-details[data-accountid='${account.id}']`)
    .children(".account-details-background")
    .addClass("account-details-selected");

  PushTransactions(SelectedAccount.transactions);
}

function LoadDebug() {
  window.postMessage({
    action: "showMenu",
    playerName: "Jack Smith",
    accounts: [
      new Account(12345, "Personal Account", 30000, [
        new Transaction("deposit", 4000, "Aga bu para burada kalsin"),
        new Transaction("withdraw", 2000, "Lazim oldu geri aldim"),
        new Transaction("deposit", 14000, null),
        new Transaction("transfer", 4000, "Aga bu para burada kalsin", 31),
      ]),
      new Account(53135, "Business Account", 1050000, [
        new Transaction("deposit", 40400, "Aga bu para burada kalsin"),
        new Transaction("transfer", 12000, "Aga bu para burada kalsin", 31),
      ]),
      new Account(47135, "Party Account", 5000, []),
    ],
  });

  Wait = () => true;
  GetParentResourceName = () => "";
}

$(document).ready(async () => {
  //await LoadBankingMenu();
  //LoadDebug();


  $(".modal-select-account-list .account").on("click", (e) => {
    $(e.currentTarget).parent().css("display", "none");
  });

  $("#exit-btn").on("click", () => {
    $.post(`https://${GetParentResourceName()}/exitMenu`);
  });

  $(".screen-fade").on("click", (e) => ShowModal(null));

  $(".modal-submit-btn").on("click", (e) => {
    const modalType = $(e.currentTarget)
      .parent()
      .attr("class")
      .split(" ")[1]
      .replace("modal-", "");
    const accountId = $(e.currentTarget).parent().attr("data-accountid");
    const account = GetAccount(accountId);

    if (!account && modalType != "createaccount") return;

    switch (modalType) {
      case "deposit":
        $.post(
          `https://${GetParentResourceName()}/deposit`,
          JSON.stringify({
            account,
            action: {
              amount: $(e.currentTarget).parent().find("input").val(),
              description: $(e.currentTarget).parent().find("textarea").val(),
            },
          })
        );
        break;
      case "transfer":
        $.post(
          `https://${GetParentResourceName()}/transfer`,
          JSON.stringify({
            account,
            action: {
              amount: $(e.currentTarget).parent().find("#amount").val(),
              targetId: $(e.currentTarget).parent().find("#account-id").val(),
              description: $(e.currentTarget).parent().find("textarea").val(),
            },
          })
        );
        break;
      case "withdraw":
        $.post(
          `https://${GetParentResourceName()}/withdraw`,
          JSON.stringify({
            account,
            action: {
              amount: $(e.currentTarget).parent().find("input").val(),
              description: $(e.currentTarget).parent().find("textarea").val(),
            },
          })
        );
        break;
      case "createaccount":
        $.post(
          `https://${GetParentResourceName()}/create-account`,
          JSON.stringify({
            account,
            action: {
              name: $(e.currentTarget).parent().find("input").val(),
            },
          })
        );
        break;

      case "deleteaccount":
        $.post(
          `https://${GetParentResourceName()}/delete-account`,
          JSON.stringify({
            account,
          })
        );
        break;
    }

    ShowModal(null);
  });

  $(document).on("keydown", (key) => {
    if (key.code == "Escape") {
      if (!$(".screen-fade").attr("style")) {
        return ShowModal(null);
      }

      $.post(`https://${GetParentResourceName()}/exitMenu`);
    }
  });
});

window.addEventListener("message", ({ data }) => {
  switch (data.action) {
    case "showMenu":
      playerBank = data.playerBank;
      transactionsList = data.transactions;
      $("#selected-account-balance").text('$' + playerBank);
      $('#account-money-details').text('$' + playerBank);
      $('#selected-account-id').text(data.playerAccount);
      $('.account-details-user-accountid').text(data.playerAccount);
      $('#account-card-owner').text(data.playerName);
      $('#account-card-id').text(data.playerAccount);
      $('#iban-account-info-player').text(data.playerAccount);
      $('#money-account-info-player').text(playerBank);
      if (data?.accounts && data?.accounts.length >= 1) {
        Accounts = [];
        SelectedAccount = null;

        for (let i = 0; i < data.accounts.length; i++) {
          Accounts.push(
            new Account(
              data.accounts[i].id,
              data.accounts[i].name,
              data.accounts[i].balance,
              data.accounts[i].transactions?.map(
                (transaction) =>
                  new Transaction(
                    transaction.type,
                    transaction.amount,
                    transaction.description,
                    transaction.targetId
                  )
              )
            )
          );
        }
      }
      if (data?.playerName) PlayerName = data.playerName;
      setupTransactions();
      LoadBankingMenu();
      $(".container").fadeIn(450);
      break;

    case "hideMenu":
      ShowModal(null);
      $(".container").fadeOut(100);
      $(".wrapper").fadeOut(100);
      break;

    case "updateAccounts":
      if (data?.accounts) {
        for (let x = 0; x < data?.accounts.length; x++) {
          let acc = data.accounts[x];

          for (let i = 0; i < Accounts.length; i++) {
            if (Accounts[i].id == acc.id) {
              Accounts[i] = new Account(
                acc.id,
                acc.name,
                acc.balance,
                acc.transactions.map(
                  (transaction) =>
                    new Transaction(
                      transaction.type,
                      transaction.amount,
                      transaction.description,
                      transaction.targetId
                    )
                )
              );
              break;
            }
          }
        }

        LoadAccounts();
        SelectedAccount = null;
        SelectAccount(
          data.accounts.length == 1
            ? Accounts.find((x) => x.id == data.accounts[0].id)?.id || null
            : Accounts[0]?.id || null
        );
      }
      break;

    case "addAccount":
      if (data?.account) {
        Accounts.push(
          new Account(
            data.account.id,
            data.account.name,
            data.account.balance,
            data.account.transactions.map(
              (transaction) =>
                new Transaction(
                  transaction.type,
                  transaction.amount,
                  transaction.description,
                  transaction.targetId
                )
            )
          )
        );

        LoadAccounts();
        SelectedAccount = null;
        SelectAccount(Accounts.find((x) => x.id == data.account.id)?.id);
      }

      break;

    case "deleteAccount":
      if (data?.account) {
        Accounts = Accounts.filter((x) => x.id != data.account?.id);

        LoadAccounts();
        SelectedAccount = null;
        SelectAccount(Accounts[0]?.id);
      }
      break;


    case 'updateMoneyDeposited':
      $('#selected-account-balance').text('$' + data.playerBank);
      $('#account-money-details').text('$' + data.playerBank);
      transactionsList = data.transactions;
      setupTransactions();
      break;
  }
});

$(document).on('click', '#deposit-money', function () {
  var amount = $('#deposit-amount').val();
  $(".modal-deposit").css("display", "none");
  $(".screen-fade").fadeOut(400)
  $.post('https://sgx-banking/action', JSON.stringify({
				action: "deposit-money-bank",
				amount: amount,
			}));
});

$(document).on('click', '#withdraw-money', function () {
  var amount = $('#withdraw-amount').val();
  $(".modal-withdraw").css("display", "none");
  $(".screen-fade").fadeOut(400)
  $.post('https://sgx-banking/action', JSON.stringify({
				action: "withdraw-money-bank",
				amount: amount,
			}));
});


function setupTransactions() {
  $(".selected-account-transactions").html('');
   if (transactionsList.length == 0) {
    $(".selected-account-transactions").append(
      `<div style="height: 100%; width: 100%; display: flex; align-items: center; justify-content: center; color: #818594;">No transactions found</div>`
    );
    return;
  }
  
  for (let i = 0; i < transactionsList.length; i++) {
    var image;
    var boxinfo;
    if (transactionsList[i].type == 'deposit') {
      image = 'images/money-deposit.svg';
      boxinfo = 'box-glow';
    } else if (transactionsList[i].type == 'withdraw') {
      image = 'images/money-withdraw.svg';
      boxinfo = 'box-glow box-glow-red';
    }
    $(".selected-account-transactions").append(`
      <div class="selected-account-transaction">
        <div class="transaction-background"></div>
        <div class="transaction-type">
          <div
            style="height: 2vh; width: 2vh; top: 0.5vh; left: 0.5vh"
            class="${boxinfo}"
          ></div>
          <img src="${image}" />
        </div>
        <div class="transaction-description">
          ${transactionsList[i].description}
        </div>
      </div>
    `);
  } 
}