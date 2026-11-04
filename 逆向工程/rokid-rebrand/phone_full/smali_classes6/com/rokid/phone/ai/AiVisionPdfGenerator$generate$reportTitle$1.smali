.class final synthetic Lcom/rokid/phone/ai/AiVisionPdfGenerator$generate$reportTitle$1;
.super Lkotlin/jvm/internal/FunctionReferenceImpl;
.source "AiVisionPdfGenerator.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function1;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/phone/ai/AiVisionPdfGenerator;->generate(Landroid/content/Context;Ljava/util/List;J)Lcom/rokid/phone/ai/AiVisionPdfGenerator$Result;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1018
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lkotlin/jvm/internal/FunctionReferenceImpl;",
        "Lkotlin/jvm/functions/Function1<",
        "Lcom/rokid/phone/ai/AiVisionRecord;",
        "Ljava/lang/String;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    k = 0x3
    mv = {
        0x2,
        0x2,
        0x0
    }
    xi = 0x30
.end annotation


# direct methods
.method constructor <init>(Ljava/lang/Object;)V
    .locals 7

    const-class v3, Lcom/rokid/phone/ai/AiVisionAnswerPolicy;

    const-string v5, "resolveReportTitle(Lcom/rokid/phone/ai/AiVisionRecord;)Ljava/lang/String;"

    const/4 v6, 0x0

    const/4 v1, 0x1

    const-string v4, "resolveReportTitle"

    move-object v0, p0

    move-object v2, p1

    invoke-direct/range {v0 .. v6}, Lkotlin/jvm/internal/FunctionReferenceImpl;-><init>(ILjava/lang/Object;Ljava/lang/Class;Ljava/lang/String;Ljava/lang/String;I)V

    return-void
.end method


# virtual methods
.method public bridge synthetic invoke(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1
    .param p1, "p1"    # Ljava/lang/Object;

    .line 117
    move-object v0, p1

    check-cast v0, Lcom/rokid/phone/ai/AiVisionRecord;

    invoke-virtual {p0, v0}, Lcom/rokid/phone/ai/AiVisionPdfGenerator$generate$reportTitle$1;->invoke(Lcom/rokid/phone/ai/AiVisionRecord;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public final invoke(Lcom/rokid/phone/ai/AiVisionRecord;)Ljava/lang/String;
    .locals 1
    .param p1, "p0"    # Lcom/rokid/phone/ai/AiVisionRecord;

    const-string v0, "p0"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 117
    iget-object v0, p0, Lcom/rokid/phone/ai/AiVisionPdfGenerator$generate$reportTitle$1;->receiver:Ljava/lang/Object;

    check-cast v0, Lcom/rokid/phone/ai/AiVisionAnswerPolicy;

    invoke-virtual {v0, p1}, Lcom/rokid/phone/ai/AiVisionAnswerPolicy;->resolveReportTitle(Lcom/rokid/phone/ai/AiVisionRecord;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
