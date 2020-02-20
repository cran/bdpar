testthat::context("DynamicPipeline")

test_that("initialize",{
  testthat::expect_silent(DynamicPipeline$new())

  testthat::expect_silent(DynamicPipeline$new(list(TargetAssigningPipe$new())))
})

testthat::test_that("initialize error",{
  testthat::expect_error(DynamicPipeline$new(1),
                         "[DynamicPipeline][initialize][Error] Checking the type of the 'pipeline' variable: numeric",
                         fixed = TRUE)

  testthat::expect_error(DynamicPipeline$new(list(1)),
                         "[DynamicPipeline][initialize][Error] Define pipes are not correct. Must be inherit from 'GenericPipe' class. Aborting...",
                         fixed = TRUE)
})

testthat::test_that("add",{

  pipeline <- DynamicPipeline$new()
  testthat::expect_length(pipeline$get(), 0)
  pipeline$add(pipe = TargetAssigningPipe$new(), pos = NULL)
  testthat::expect_length(pipeline$get(), 1)

  pipeline <- DynamicPipeline$new()
  testthat::expect_warning(pipeline$add(pipe = File2Pipe$new(), pos = 2),
                           "[DynamicPipeline][add][Warning] Pipeline empty, adding in the first position",
                           fixed = TRUE)

  pipeline <- DynamicPipeline$new()
  testthat::expect_length(pipeline$get(), 0)
  pipeline$add(pipe = list(TargetAssigningPipe$new(), StoreFileExtPipe$new()), pos = NULL)
  testthat::expect_length(pipeline$get(), 2)

  testthat::expect_warning(pipeline$add(pipe = File2Pipe$new(), pos = 3),
                           "[DynamicPipeline][add][Warning] The position exceeds the length of the pipeline, adding at the end of it",
                           fixed = TRUE)
  testthat::expect_length(pipeline$get(), 3)
  pipeline$add(pipe = GuessDatePipe$new(), pos = 3)
  testthat::expect_length(pipeline$get(), 4)

  testthat::expect_error(pipeline$add(pipe = GuessDatePipe$new(), pos = -2),
                         "[DynamicPipeline][add][Error] It can only be added between positions '0' and '4'",
                         fixed = TRUE)
})

testthat::test_that("add error",{

  pipeline <- DynamicPipeline$new()
  testthat::expect_error(pipeline$add(pipe = 1, pos = NULL),
                         "[DynamicPipeline][add][Error] Checking the type of the 'pipe' variable: list",
                         fixed = TRUE)

  testthat::expect_error(pipeline$add(pipe = GuessDatePipe$new(), pos = "wrong"),
                         "[DynamicPipeline][add][Error] Checking the type of the 'pos' variable: character",
                         fixed = TRUE)
})

testthat::test_that("removeByPos",{

  pipeline <- DynamicPipeline$new()
  pipeline$add(pipe = TargetAssigningPipe$new(), pos = NULL)
  testthat::expect_length(pipeline$get(), 1)
  pipeline$removeByPos(pos = 1)
  testthat::expect_length(pipeline$get(), 0)

})

testthat::test_that("removeByPos error",{

  pipeline <- DynamicPipeline$new()
  testthat::expect_warning(pipeline$removeByPos(pos = 1),
                           "[DynamicPipeline][removeByPos][Warning] Pipeline empty. Imposible remove",
                           fixed = TRUE)

  testthat::expect_error(pipeline$removeByPos(pos = "A"),
                         "[DynamicPipeline][removeByPos][Error] Checking the type of the 'pos' variable: character",
                         fixed = TRUE)

  pipeline$add(pipe = GuessDatePipe$new())
  testthat::expect_error(pipeline$removeByPos(pos = 3),
                         "[DynamicPipeline][removeByPos][Error] It can only be deleted between positions '0' and '1'",
                         fixed = TRUE)
})

testthat::test_that("removeByPipe",{

  pipeline <- DynamicPipeline$new()
  pipeline$add(pipe = TargetAssigningPipe$new(), pos = NULL)
  testthat::expect_length(pipeline$get(), 1)
  pipeline$removeByPipe(pipe = "TargetAssigningPipe")
  testthat::expect_length(pipeline$get(), 0)

})

testthat::test_that("removeByPipe error",{

  pipeline <- DynamicPipeline$new()
  testthat::expect_warning(pipeline$removeByPipe(pipe.name = "TargetAssigningPipe"),
                           "[DynamicPipeline][removeByPipe][Warning] Pipeline empty. Imposible remove",
                           fixed = TRUE)

  testthat::expect_error(pipeline$removeByPipe(pipe = 1),
                         "[DynamicPipeline][removeByPipe][Error] Checking the type of the 'pipe.name' variable (must be a character list)",
                         fixed = TRUE)

  pipeline$add(pipe = GuessDatePipe$new())
  testthat::expect_warning(pipeline$removeByPipe(pipe.name = "a"),
                           "[DynamicPipeline][removeByPipe][Warning] Not found elements to remove",
                           fixed = TRUE)
})

testthat::test_that("execute instance type error",{

  instance <- NULL
  testthat::expect_error(DynamicPipeline$new()$execute(instance),
                         "[DynamicPipeline][execute][Error] Checking the type of the 'instance' variable: NULL",
                         fixed = TRUE)
})

if (Sys.info()[['sysname']] %in% "Windows") {

  testthat::setup(bdpar.Options$reset())

  testthat::test_that("execute",{
    testthat::skip_if_not_installed("cld2")
    testthat::skip_if_not_installed("readr")
    testthat::skip_if_not_installed("rex")
    testthat::skip_if_not_installed("rjson")
    testthat::skip_if_not_installed("rtweet")
    testthat::skip_if_not_installed("stringi")
    testthat::skip_if_not_installed("stringr")
    testthat::skip_if_not_installed("textutils")
    path <- file.path("testFiles",
                      "testDynamicPipeline",
                      "files",
                      "_ham_",
                      "testFile.tsms")

    bdpar.Options$set("extractorEML.mpaPartSelected", "text/plain")
    bdpar.Options$set("resources.abbreviations.path", "")
    bdpar.Options$set("resources.contractions.path", "")
    bdpar.Options$set("resources.interjections.path", "")
    bdpar.Options$set("resources.slangs.path", "")
    bdpar.Options$set("resources.stopwords.path", "")
    bdpar.Options$set("teeCSVPipe.output.path", "output_tsms.csv")

    Bdpar$new()
    instance <- ExtractorSms$new(path)
    instanceInitial <- ExtractorSms$new(path)

    instance$setDate("")

    instance$setSource("Wait that's still not all that clear, were you not sure about me being sarcastic or that that's why x doesn't want to live with us\r\n")

    instance$setData("Wait that's still not all that clear, were you not sure about me being sarcastic or that that's why x doesn't want to live with us\r\n")
    instance$setSpecificProperty("target", "ham")
    instance$setSpecificProperty("extension", "tsms")

    instance$addFlowPipes("TargetAssigningPipe")
    instance$addFlowPipes("StoreFileExtPipe")
    instance$addFlowPipes("GuessDatePipe")
    instance$addFlowPipes("File2Pipe")

    pipeline <- DynamicPipeline$new()
    pipeline$add(list(TargetAssigningPipe$new(), StoreFileExtPipe$new(), GuessDatePipe$new(), File2Pipe$new()))
    suppressWarnings(pipeline$execute(instanceInitial))
    testthat::expect_equal(instanceInitial,
                           instance)
  })

  testthat::teardown(bdpar.Options$reset())
}

if (Sys.info()[['sysname']] %in% "Windows") {

  testthat::setup(bdpar.Options$reset())

  testthat::test_that("execute error",{
    testthat::skip_if_not_installed("readr")
    path <- file.path("testFiles",
                      "testDynamicPipeline",
                      "files",
                      "_ham_",
                      "testFileEmpty.tsms")

    Bdpar$new()

    instanceInitial <- ExtractorSms$new(path)
    instance <- ExtractorSms$new(path)

    instance$setDate("")

    instance$setSource("")

    instance$setData("")
    instance$setSpecificProperty("target", "ham")
    instance$setSpecificProperty("extension", "tsms")
    instance$addFlowPipes("TargetAssigningPipe")
    instance$addFlowPipes("StoreFileExtPipe")
    instance$addFlowPipes("GuessDatePipe")
    instance$addFlowPipes("File2Pipe")

    instance$addBanPipes(c("FindUrlPipe", "FindHashtagPipe", "AbbreviationPipe"))

    pipeline <- DynamicPipeline$new()
    pipeline$add(list(TargetAssigningPipe$new(), StoreFileExtPipe$new(), GuessDatePipe$new(), File2Pipe$new()))
    testthat::expect_message(suppressWarnings(pipeline$execute(instanceInitial)),
                             "[pipeOperator][freduce][Info] The instance testFiles/testDynamicPipeline/files/_ham_/testFileEmpty.tsms is invalid and will not continue through the flow of pipes",
                             fixed = TRUE)

    pipeline <- DynamicPipeline$new()
    testthat::expect_error(suppressWarnings(pipeline$execute(instanceInitial)),
                           "[DynamicPipeline][execute][Error] Pipeline is empty",
                           fixed = TRUE)
  })

  testthat::teardown(bdpar.Options$reset())
}

testthat::test_that("removeAll",{

  pipeline <- DynamicPipeline$new(list(TargetAssigningPipe$new()))

  testthat::expect_length(pipeline$get(), 1)

  pipeline$removeAll()

  testthat::expect_length(pipeline$get(), 0)
})

testthat::test_that("get",{
  testthat::expect_equal(DynamicPipeline$new()$get(), list())

  testthat::expect_equal(DynamicPipeline$new(list(TargetAssigningPipe$new()))$get(),
                         list(TargetAssigningPipe$new()))
})

testthat::test_that("print",{
  pipeline <- DynamicPipeline$new(list(TargetAssigningPipe$new()))
  testthat::expect_output(print(pipeline), "[A-Za-z0-9$/.\\(\\)%>]+")
})