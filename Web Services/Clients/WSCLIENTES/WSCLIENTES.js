urlBase = "http://{ip}:{port}/rest/WSCLIENTES"

$(document).ready(function () {
});

$("#btnClear").click(function (e) {
    $("#nome").removeAttr('readonly', true);
    $("#razao").removeAttr('readonly', true);
    $("#pessoa").removeAttr('readonly', true);
    $("#tipo").removeAttr('readonly', true);
    $("#cnpj").removeAttr('readonly', true);
    $("#ie").removeAttr('readonly', true);
    $("#email").removeAttr('readonly', true);
    $("#cep").removeAttr('readonly', true);
    $("#endereco").removeAttr('readonly', true);
    $("#bairro").removeAttr('readonly', true);
    $("#uf").removeAttr('readonly', true);
    $("#municipio").removeAttr('readonly', true);
    $("#ddd").removeAttr('readonly', true);
    $("#telefone").removeAttr('readonly', true);
});

$("#btnSearch").click(function (e) {
    e.preventDefault();

    // Set url.
    if ($("#ip").val().length === 0 || $("#port").val().length === 0) {
        $("#success").hide();
        $("#error").show();
        $("#error").text("Preencha IP e Porta.");
    }

    url = urlBase.replace('{ip}', $("#ip").val())
    url = url.replace('{port}', $("#port").val())

    // Set route.
    if ($("#rCodigo")[0].checked) {
        urlRoute = "/codigo/"
    } else {
        urlRoute = "/cnpj/"
    }

    username = $("#username").val()
    password = $("#password").val()
    authorization = username + ":" + password
    authorization = "Basic " + btoa(authorization)

    // Get find value.
    cId = $("#busca").val()

    $.ajax({
        type: "GET",
        url: url + urlRoute + cId,
        dataType: 'json',
        async: false,
        headers: {
            "Authorization": authorization
        },
        success: function (resp) {
            // Load data.
            $("#nome").val(resp.nome);
            $("#nome").attr('readonly', true);
            $("#razao").val(resp.razao);
            $("#razao").attr('readonly', true);
            $("#pessoa").val(resp.pessoa);
            $("#pessoa").attr('readonly', true);
            $("#tipo").val(resp.tipo);
            $("#tipo").attr('readonly', true);
            $("#cnpj").val(resp.cnpj);
            $("#cnpj").attr('readonly', true);
            $("#ie").val(resp.ie);
            $("#ie").attr('readonly', true);
            $("#email").val(resp.email);
            $("#email").attr('readonly', true);
            $("#cep").val(resp.cep);
            $("#cep").attr('readonly', true);
            $("#endereco").val(resp.endereco);
            $("#endereco").attr('readonly', true);
            $("#bairro").val(resp.bairro);
            $("#bairro").attr('readonly', true);
            $("#uf").val(resp.uf);
            $("#uf").attr('readonly', true);
            $("#municipio").val(resp.municipio);
            $("#municipio").attr('readonly', true);
            $("#ddd").val(resp.ddd);
            $("#ddd").attr('readonly', true);
            $("#telefone").val(resp.telefone);
            $("#telefone").attr('readonly', true);
            // Set msg.
            $("#error").hide();
            $("#success").show();
            $("#success").text('Cliente localizado!');
        },
        error: function (resp) {
            // Set msg.
            $("#success").hide();
            $("#error").show();
            if (resp.responseJSON.message) {
                $("#error").text(resp.responseJSON.message);
            } else if (resp.responseJSON.errorMessage) {
                $("#error").text(resp.responseJSON.errorMessage);
            }
        }
    });
});

$("form").submit(function (e) {
    e.preventDefault();

    // Set url.
    if ($("#ip").val().length === 0 || $("#port").val().length === 0) {
        $("#success").hide();
        $("#error").show();
        $("#error").text("Preencha IP e Porta.");
    }

    url = urlBase.replace('{ip}', $("#ip").val())
    url = url.replace('{port}', $("#port").val())

    data = {
        nome: $("#nome").val(),
        razao: $("#razao").val(),
        pessoa: $("#pessoa").val(),
        tipo: $("#tipo").val(),
        cnpj: $("#cnpj").val(),
        ie: $("#ie").val(),
        cep: $("#cep").val(),
        endereco: $("#endereco").val(),
        bairro: $("#bairro").val(),
        uf: $("#uf").val(),
        municipio: $("#municipio").val(),
        email: $("#email").val(),
        ddd: $("#ddd").val(),
        telefone: $("#telefone").val()
    }

    $.post(url, JSON.stringify(data))
        .done(() => {
            $("#error").hide();
            $("#success").show();
            $("#success").text('Cadastro efetuado com sucesso!');
        })
        .fail((x, y, z) => {
            $("#success").hide();
            $("#error").show();
            $("#error").text(x.responseJSON.errorMessage);
        })
        .always(() => {
        });

});