.class public final Lcom/rokid/glasses/transport/sdk/api/callback/IResultKt;
.super Ljava/lang/Object;
.source "IResult.kt"


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nIResult.kt\nKotlin\n*S Kotlin\n*F\n+ 1 IResult.kt\ncom/rokid/glasses/transport/sdk/api/callback/IResultKt\n+ 2 IResult.kt\ncom/rokid/glasses/transport/sdk/api/callback/IResult$Companion\n+ 3 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,337:1\n147#1,2:343\n149#1,2:346\n147#1,2:350\n149#1,2:353\n84#2:338\n93#2:339\n84#2:340\n93#2:341\n84#2:342\n84#2:345\n93#2:348\n84#2:349\n84#2:352\n93#2:355\n1#3:356\n*S KotlinDebug\n*F\n+ 1 IResult.kt\ncom/rokid/glasses/transport/sdk/api/callback/IResultKt\n*L\n264#1:343,2\n264#1:346,2\n303#1:350,2\n303#1:353,2\n134#1:338\n136#1:339\n148#1:340\n150#1:341\n247#1:342\n264#1:345\n264#1:348\n286#1:349\n303#1:352\n303#1:355\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000:\n\u0000\n\u0002\u0010\u0000\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0004\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0015\n\u0002\u0010\u0002\n\u0002\u0008\u0006\n\u0002\u0018\u0002\n\u0002\u0008\u0004\u001a\u0010\u0010\u0000\u001a\u00020\u00012\u0006\u0010\u0002\u001a\u00020\u0003H\u0001\u001a.\u0010\u0004\u001a\u0008\u0012\u0004\u0012\u0002H\u00060\u0005\"\u0004\u0008\u0000\u0010\u00062\u000c\u0010\u0007\u001a\u0008\u0012\u0004\u0012\u0002H\u00060\u0008H\u0087\u0008\u00f8\u0001\u0000\u00f8\u0001\u0001\u00a2\u0006\u0002\u0010\t\u001a\u0092\u0001\u0010\n\u001a\u0004\u0018\u0001H\u0006\"\u0004\u0008\u0000\u0010\u000b\"\u0004\u0008\u0001\u0010\u0006*\u0008\u0012\u0004\u0012\u0002H\u000b0\u00052!\u0010\u000c\u001a\u001d\u0012\u0013\u0012\u0011H\u000b\u00a2\u0006\u000c\u0008\u000e\u0012\u0008\u0008\u000f\u0012\u0004\u0008\u0008(\u0010\u0012\u0004\u0012\u0002H\u00060\r2%\u0008\u0002\u0010\u0011\u001a\u001f\u0012\u0013\u0012\u00110\u0003\u00a2\u0006\u000c\u0008\u000e\u0012\u0008\u0008\u000f\u0012\u0004\u0008\u0008(\u0002\u0012\u0006\u0012\u0004\u0018\u0001H\u00060\rH\u0087\u0008\u00f8\u0001\u0000\u00f8\u0001\u0002\u00f8\u0001\u0001\u0082\u0002\u0014\n\u0008\u0008\u0001\u0012\u0002\u0010\u0001 \u0000\n\u0008\u0008\u0001\u0012\u0002\u0010\u0002 \u0000\u00a2\u0006\u0004\u0008\u0012\u0010\u0013\u001a8\u0010\u0014\u001a\u0002H\u0006\"\u0004\u0008\u0000\u0010\u0006\"\u0008\u0008\u0001\u0010\u000b*\u0002H\u0006*\u0008\u0012\u0004\u0012\u0002H\u000b0\u00052\u0006\u0010\u0015\u001a\u0002H\u0006H\u0087\u0008\u00f8\u0001\u0002\u00f8\u0001\u0001\u00a2\u0006\u0004\u0008\u0016\u0010\u0017\u001ac\u0010\u0018\u001a\u0002H\u0006\"\u0004\u0008\u0000\u0010\u0006\"\u0008\u0008\u0001\u0010\u000b*\u0002H\u0006*\u0008\u0012\u0004\u0012\u0002H\u000b0\u00052!\u0010\u0011\u001a\u001d\u0012\u0013\u0012\u00110\u0003\u00a2\u0006\u000c\u0008\u000e\u0012\u0008\u0008\u000f\u0012\u0004\u0008\u0008(\u0002\u0012\u0004\u0012\u0002H\u00060\rH\u0087\u0008\u00f8\u0001\u0000\u00f8\u0001\u0002\u00f8\u0001\u0001\u0082\u0002\n\n\u0008\u0008\u0001\u0012\u0002\u0010\u0001 \u0000\u00a2\u0006\u0004\u0008\u0019\u0010\u001a\u001a&\u0010\u001b\u001a\u0002H\u000b\"\u0004\u0008\u0000\u0010\u000b*\u0008\u0012\u0004\u0012\u0002H\u000b0\u0005H\u0087\u0008\u00f8\u0001\u0002\u00f8\u0001\u0001\u00a2\u0006\u0004\u0008\u001c\u0010\u001d\u001ae\u0010\u001e\u001a\u0008\u0012\u0004\u0012\u0002H\u00060\u0005\"\u0004\u0008\u0000\u0010\u0006\"\u0004\u0008\u0001\u0010\u000b*\u0008\u0012\u0004\u0012\u0002H\u000b0\u00052!\u0010\u001f\u001a\u001d\u0012\u0013\u0012\u0011H\u000b\u00a2\u0006\u000c\u0008\u000e\u0012\u0008\u0008\u000f\u0012\u0004\u0008\u0008(\u0010\u0012\u0004\u0012\u0002H\u00060\rH\u0087\u0008\u00f8\u0001\u0000\u00f8\u0001\u0002\u00f8\u0001\u0001\u0082\u0002\n\n\u0008\u0008\u0001\u0012\u0002\u0010\u0001 \u0000\u00a2\u0006\u0004\u0008 \u0010\u001a\u001aX\u0010!\u001a\u0008\u0012\u0004\u0012\u0002H\u00060\u0005\"\u0004\u0008\u0000\u0010\u0006\"\u0004\u0008\u0001\u0010\u000b*\u0008\u0012\u0004\u0012\u0002H\u000b0\u00052!\u0010\u001f\u001a\u001d\u0012\u0013\u0012\u0011H\u000b\u00a2\u0006\u000c\u0008\u000e\u0012\u0008\u0008\u000f\u0012\u0004\u0008\u0008(\u0010\u0012\u0004\u0012\u0002H\u00060\rH\u0087\u0008\u00f8\u0001\u0000\u00f8\u0001\u0002\u00f8\u0001\u0001\u00a2\u0006\u0004\u0008\"\u0010\u001a\u001a_\u0010\u0011\u001a\u0008\u0012\u0004\u0012\u0002H\u000b0\u0005\"\u0004\u0008\u0000\u0010\u000b*\u0008\u0012\u0004\u0012\u0002H\u000b0\u00052!\u0010#\u001a\u001d\u0012\u0013\u0012\u00110\u0003\u00a2\u0006\u000c\u0008\u000e\u0012\u0008\u0008\u000f\u0012\u0004\u0008\u0008(\u0002\u0012\u0004\u0012\u00020$0\rH\u0087\u0008\u00f8\u0001\u0000\u00f8\u0001\u0002\u00f8\u0001\u0001\u0082\u0002\n\n\u0008\u0008\u0001\u0012\u0002\u0010\u0001 \u0000\u00a2\u0006\u0004\u0008%\u0010\u001a\u001a_\u0010\u000c\u001a\u0008\u0012\u0004\u0012\u0002H\u000b0\u0005\"\u0004\u0008\u0000\u0010\u000b*\u0008\u0012\u0004\u0012\u0002H\u000b0\u00052!\u0010#\u001a\u001d\u0012\u0013\u0012\u0011H\u000b\u00a2\u0006\u000c\u0008\u000e\u0012\u0008\u0008\u000f\u0012\u0004\u0008\u0008(\u0010\u0012\u0004\u0012\u00020$0\rH\u0087\u0008\u00f8\u0001\u0000\u00f8\u0001\u0002\u00f8\u0001\u0001\u0082\u0002\n\n\u0008\u0008\u0001\u0012\u0002\u0010\u0001 \u0000\u00a2\u0006\u0004\u0008&\u0010\u001a\u001ai\u0010\'\u001a\u0008\u0012\u0004\u0012\u0002H\u00060\u0005\"\u0004\u0008\u0000\u0010\u0006\"\u0008\u0008\u0001\u0010\u000b*\u0002H\u0006*\u0008\u0012\u0004\u0012\u0002H\u000b0\u00052!\u0010\u001f\u001a\u001d\u0012\u0013\u0012\u00110\u0003\u00a2\u0006\u000c\u0008\u000e\u0012\u0008\u0008\u000f\u0012\u0004\u0008\u0008(\u0002\u0012\u0004\u0012\u0002H\u00060\rH\u0087\u0008\u00f8\u0001\u0000\u00f8\u0001\u0002\u00f8\u0001\u0001\u0082\u0002\n\n\u0008\u0008\u0001\u0012\u0002\u0010\u0001 \u0000\u00a2\u0006\u0004\u0008(\u0010\u001a\u001a\\\u0010)\u001a\u0008\u0012\u0004\u0012\u0002H\u00060\u0005\"\u0004\u0008\u0000\u0010\u0006\"\u0008\u0008\u0001\u0010\u000b*\u0002H\u0006*\u0008\u0012\u0004\u0012\u0002H\u000b0\u00052!\u0010\u001f\u001a\u001d\u0012\u0013\u0012\u00110\u0003\u00a2\u0006\u000c\u0008\u000e\u0012\u0008\u0008\u000f\u0012\u0004\u0008\u0008(\u0002\u0012\u0004\u0012\u0002H\u00060\rH\u0087\u0008\u00f8\u0001\u0000\u00f8\u0001\u0002\u00f8\u0001\u0001\u00a2\u0006\u0004\u0008*\u0010\u001a\u001aC\u0010\u0004\u001a\u0008\u0012\u0004\u0012\u0002H\u00060\u0005\"\u0004\u0008\u0000\u0010\u000b\"\u0004\u0008\u0001\u0010\u0006*\u0002H\u000b2\u0017\u0010\u0007\u001a\u0013\u0012\u0004\u0012\u0002H\u000b\u0012\u0004\u0012\u0002H\u00060\r\u00a2\u0006\u0002\u0008+H\u0087\u0008\u00f8\u0001\u0000\u00f8\u0001\u0001\u00a2\u0006\u0002\u0010\u001a\u001a\u001d\u0010,\u001a\u00020$*\u0006\u0012\u0002\u0008\u00030\u0005H\u0001\u00f8\u0001\u0002\u00f8\u0001\u0001\u00a2\u0006\u0004\u0008-\u0010.\u0082\u0002\u0012\n\u0005\u0008\u009920\u0001\n\u0002\u0008\u0019\n\u0005\u0008\u00a1\u001e0\u0001\u00a8\u0006/"
    }
    d2 = {
        "createFailure",
        "",
        "exception",
        "Lcom/rokid/glasses/transport/sdk/api/callback/IException;",
        "runCatching",
        "Lcom/rokid/glasses/transport/sdk/api/callback/IResult;",
        "R",
        "block",
        "Lkotlin/Function0;",
        "(Lkotlin/jvm/functions/Function0;)Ljava/lang/Object;",
        "fold",
        "T",
        "onSuccess",
        "Lkotlin/Function1;",
        "Lkotlin/ParameterName;",
        "name",
        "value",
        "onFailure",
        "fold-DM99JKI",
        "(Ljava/lang/Object;Lkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function1;)Ljava/lang/Object;",
        "getOrDefault",
        "defaultValue",
        "getOrDefault-mF4-cRc",
        "(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;",
        "getOrElse",
        "getOrElse-mF4-cRc",
        "(Ljava/lang/Object;Lkotlin/jvm/functions/Function1;)Ljava/lang/Object;",
        "getOrThrow",
        "getOrThrow-3CeXOB8",
        "(Ljava/lang/Object;)Ljava/lang/Object;",
        "map",
        "transform",
        "map-mF4-cRc",
        "mapCatching",
        "mapCatching-mF4-cRc",
        "action",
        "",
        "onFailure-mF4-cRc",
        "onSuccess-mF4-cRc",
        "recover",
        "recover-mF4-cRc",
        "recoverCatching",
        "recoverCatching-mF4-cRc",
        "Lkotlin/ExtensionFunctionType;",
        "throwOnFailure",
        "throwOnFailure-3CeXOB8",
        "(Ljava/lang/Object;)V",
        "sdk-api_release"
    }
    k = 0x2
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# direct methods
.method public static final createFailure(Lcom/rokid/glasses/transport/sdk/api/callback/IException;)Ljava/lang/Object;
    .locals 1
    .param p0, "exception"    # Lcom/rokid/glasses/transport/sdk/api/callback/IException;

    const-string v0, "exception"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 113
    new-instance v0, Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Failure;

    invoke-direct {v0, p0}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Failure;-><init>(Lcom/rokid/glasses/transport/sdk/api/callback/IException;)V

    return-object v0
.end method

.method public static final fold-DM99JKI(Ljava/lang/Object;Lkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function1;)Ljava/lang/Object;
    .locals 3
    .param p0, "$this$fold_u2dDM99JKI"    # Ljava/lang/Object;
    .param p1, "onSuccess"    # Lkotlin/jvm/functions/Function1;
    .param p2, "onFailure"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            "R:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/Object;",
            "Lkotlin/jvm/functions/Function1<",
            "-TT;+TR;>;",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Lcom/rokid/glasses/transport/sdk/api/callback/IException;",
            "+TR;>;)TR;"
        }
    .end annotation

    const-string v0, "onSuccess"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "onFailure"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const/4 v0, 0x0

    .line 219
    .local v0, "$i$f$fold-DM99JKI":I
    nop

    .line 223
    invoke-static {p0}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->exceptionOrNull-impl(Ljava/lang/Object;)Lcom/rokid/glasses/transport/sdk/api/callback/IException;

    move-result-object v1

    .line 224
    .local v1, "exception":Lcom/rokid/glasses/transport/sdk/api/callback/IException;
    if-nez v1, :cond_0

    invoke-interface {p1, p0}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    goto :goto_0

    .line 225
    :cond_0
    invoke-interface {p2, v1}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    .line 223
    .end local v1    # "exception":Lcom/rokid/glasses/transport/sdk/api/callback/IException;
    :goto_0
    return-object v2
.end method

.method public static synthetic fold-DM99JKI$default(Ljava/lang/Object;Lkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)Ljava/lang/Object;
    .locals 1
    .param p0, "$this$fold_u2dDM99JKI_u24default"    # Ljava/lang/Object;
    .param p1, "onSuccess"    # Lkotlin/jvm/functions/Function1;
    .param p2, "onFailure"    # Lkotlin/jvm/functions/Function1;

    .line 212
    and-int/lit8 p3, p3, 0x2

    if-eqz p3, :cond_0

    .line 214
    sget-object p3, Lcom/rokid/glasses/transport/sdk/api/callback/IResultKt$fold$1;->INSTANCE:Lcom/rokid/glasses/transport/sdk/api/callback/IResultKt$fold$1;

    move-object p2, p3

    check-cast p2, Lkotlin/jvm/functions/Function1;

    .line 212
    :cond_0
    const-string p3, "onSuccess"

    invoke-static {p1, p3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string p3, "onFailure"

    invoke-static {p2, p3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const/4 p3, 0x0

    .line 219
    .local p3, "$i$f$fold-DM99JKI":I
    nop

    .line 223
    invoke-static {p0}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->exceptionOrNull-impl(Ljava/lang/Object;)Lcom/rokid/glasses/transport/sdk/api/callback/IException;

    move-result-object p4

    .line 224
    .local p4, "exception":Lcom/rokid/glasses/transport/sdk/api/callback/IException;
    if-nez p4, :cond_1

    invoke-interface {p1, p0}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    goto :goto_0

    .line 225
    :cond_1
    invoke-interface {p2, p4}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 223
    .end local p4    # "exception":Lcom/rokid/glasses/transport/sdk/api/callback/IException;
    :goto_0
    return-object v0
.end method

.method public static final getOrDefault-mF4-cRc(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 2
    .param p0, "$this$getOrDefault_u2dmF4_u2dcRc"    # Ljava/lang/Object;
    .param p1, "defaultValue"    # Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<R:",
            "Ljava/lang/Object;",
            "T::TR;>(",
            "Ljava/lang/Object;",
            "TR;)TR;"
        }
    .end annotation

    const/4 v0, 0x0

    .line 199
    .local v0, "$i$f$getOrDefault-mF4-cRc":I
    invoke-static {p0}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->isFailure-impl(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    return-object p1

    .line 200
    :cond_0
    return-object p0
.end method

.method public static final getOrElse-mF4-cRc(Ljava/lang/Object;Lkotlin/jvm/functions/Function1;)Ljava/lang/Object;
    .locals 3
    .param p0, "$this$getOrElse_u2dmF4_u2dcRc"    # Ljava/lang/Object;
    .param p1, "onFailure"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<R:",
            "Ljava/lang/Object;",
            "T::TR;>(",
            "Ljava/lang/Object;",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Lcom/rokid/glasses/transport/sdk/api/callback/IException;",
            "+TR;>;)TR;"
        }
    .end annotation

    const-string v0, "onFailure"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const/4 v0, 0x0

    .line 181
    .local v0, "$i$f$getOrElse-mF4-cRc":I
    nop

    .line 184
    invoke-static {p0}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->exceptionOrNull-impl(Ljava/lang/Object;)Lcom/rokid/glasses/transport/sdk/api/callback/IException;

    move-result-object v1

    .line 185
    .local v1, "exception":Lcom/rokid/glasses/transport/sdk/api/callback/IException;
    if-nez v1, :cond_0

    move-object v2, p0

    goto :goto_0

    .line 186
    :cond_0
    invoke-interface {p1, v1}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    .line 184
    .end local v1    # "exception":Lcom/rokid/glasses/transport/sdk/api/callback/IException;
    :goto_0
    return-object v2
.end method

.method public static final getOrThrow-3CeXOB8(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1
    .param p0, "$this$getOrThrow_u2d3CeXOB8"    # Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/Object;",
            ")TT;"
        }
    .end annotation

    const/4 v0, 0x0

    .line 165
    .local v0, "$i$f$getOrThrow-3CeXOB8":I
    invoke-static {p0}, Lcom/rokid/glasses/transport/sdk/api/callback/IResultKt;->throwOnFailure-3CeXOB8(Ljava/lang/Object;)V

    .line 166
    return-object p0
.end method

.method public static final map-mF4-cRc(Ljava/lang/Object;Lkotlin/jvm/functions/Function1;)Ljava/lang/Object;
    .locals 4
    .param p0, "$this$map_u2dmF4_u2dcRc"    # Ljava/lang/Object;
    .param p1, "transform"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<R:",
            "Ljava/lang/Object;",
            "T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/Object;",
            "Lkotlin/jvm/functions/Function1<",
            "-TT;+TR;>;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    const-string v0, "transform"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const/4 v0, 0x0

    .line 243
    .local v0, "$i$f$map-mF4-cRc":I
    nop

    .line 246
    nop

    .line 247
    invoke-static {p0}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->isSuccess-impl(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    sget-object v1, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->Companion:Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;

    .local v1, "this_$iv":Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;
    invoke-interface {p1, p0}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    .local v2, "value$iv":Ljava/lang/Object;
    const/4 v3, 0x0

    .line 342
    .local v3, "$i$f$success":I
    invoke-static {v2}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    .end local v1    # "this_$iv":Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;
    .end local v2    # "value$iv":Ljava/lang/Object;
    .end local v3    # "$i$f$success":I
    goto :goto_0

    .line 248
    :cond_0
    invoke-static {p0}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    .line 246
    :goto_0
    return-object v1
.end method

.method public static final mapCatching-mF4-cRc(Ljava/lang/Object;Lkotlin/jvm/functions/Function1;)Ljava/lang/Object;
    .locals 7
    .param p0, "$this$mapCatching_u2dmF4_u2dcRc"    # Ljava/lang/Object;
    .param p1, "transform"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<R:",
            "Ljava/lang/Object;",
            "T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/Object;",
            "Lkotlin/jvm/functions/Function1<",
            "-TT;+TR;>;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    const-string v0, "transform"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const/4 v0, 0x0

    .line 263
    .local v0, "$i$f$mapCatching-mF4-cRc":I
    nop

    .line 264
    invoke-static {p0}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->isSuccess-impl(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    move-object v1, p0

    .local v1, "$this$runCatching$iv":Ljava/lang/Object;
    const/4 v2, 0x0

    .line 343
    .local v2, "$i$f$runCatching":I
    nop

    .line 344
    :try_start_0
    sget-object v3, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->Companion:Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;

    move-object v4, v1

    .local v4, "$this$mapCatching_mF4_cRc_u24lambda_u243":Ljava/lang/Object;
    const/4 v5, 0x0

    .line 264
    .local v5, "$i$a$-runCatching-IResultKt$mapCatching$1":I
    invoke-interface {p1, v4}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    .line 344
    .end local v4    # "$this$mapCatching_mF4_cRc_u24lambda_u243":Ljava/lang/Object;
    .end local v5    # "$i$a$-runCatching-IResultKt$mapCatching$1":I
    move-object v4, v6

    .local v3, "this_$iv$iv":Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;
    .local v4, "value$iv$iv":Ljava/lang/Object;
    const/4 v5, 0x0

    .line 345
    .local v5, "$i$f$success":I
    invoke-static {v4}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6
    :try_end_0
    .catch Lcom/rokid/glasses/transport/sdk/api/callback/IException; {:try_start_0 .. :try_end_0} :catch_0

    .end local v3    # "this_$iv$iv":Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;
    .end local v4    # "value$iv$iv":Ljava/lang/Object;
    .end local v5    # "$i$f$success":I
    goto :goto_0

    .line 346
    :catch_0
    move-exception v3

    .line 347
    .local v3, "e$iv":Lcom/rokid/glasses/transport/sdk/api/callback/IException;
    sget-object v4, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->Companion:Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;

    .local v4, "this_$iv$iv":Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;
    const/4 v5, 0x0

    .line 348
    .local v5, "$i$f$failure":I
    invoke-static {v3}, Lcom/rokid/glasses/transport/sdk/api/callback/IResultKt;->createFailure(Lcom/rokid/glasses/transport/sdk/api/callback/IException;)Ljava/lang/Object;

    move-result-object v6

    invoke-static {v6}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    .line 343
    .end local v3    # "e$iv":Lcom/rokid/glasses/transport/sdk/api/callback/IException;
    .end local v4    # "this_$iv$iv":Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;
    .end local v5    # "$i$f$failure":I
    :goto_0
    nop

    .end local v1    # "$this$runCatching$iv":Ljava/lang/Object;
    .end local v2    # "$i$f$runCatching":I
    goto :goto_1

    .line 265
    :cond_0
    invoke-static {p0}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    .line 263
    :goto_1
    return-object v6
.end method

.method public static final onFailure-mF4-cRc(Ljava/lang/Object;Lkotlin/jvm/functions/Function1;)Ljava/lang/Object;
    .locals 3
    .param p0, "$this$onFailure_u2dmF4_u2dcRc"    # Ljava/lang/Object;
    .param p1, "action"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/Object;",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Lcom/rokid/glasses/transport/sdk/api/callback/IException;",
            "Lkotlin/Unit;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    const-string v0, "action"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const/4 v0, 0x0

    .line 317
    .local v0, "$i$f$onFailure-mF4-cRc":I
    nop

    .line 320
    invoke-static {p0}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->exceptionOrNull-impl(Ljava/lang/Object;)Lcom/rokid/glasses/transport/sdk/api/callback/IException;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 356
    .local v1, "it":Lcom/rokid/glasses/transport/sdk/api/callback/IException;
    const/4 v2, 0x0

    .line 320
    .local v2, "$i$a$-let-IResultKt$onFailure$2":I
    invoke-interface {p1, v1}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 321
    .end local v1    # "it":Lcom/rokid/glasses/transport/sdk/api/callback/IException;
    .end local v2    # "$i$a$-let-IResultKt$onFailure$2":I
    :cond_0
    return-object p0
.end method

.method public static final onSuccess-mF4-cRc(Ljava/lang/Object;Lkotlin/jvm/functions/Function1;)Ljava/lang/Object;
    .locals 2
    .param p0, "$this$onSuccess_u2dmF4_u2dcRc"    # Ljava/lang/Object;
    .param p1, "action"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/Object;",
            "Lkotlin/jvm/functions/Function1<",
            "-TT;",
            "Lkotlin/Unit;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    const-string v0, "action"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const/4 v0, 0x0

    .line 332
    .local v0, "$i$f$onSuccess-mF4-cRc":I
    nop

    .line 335
    invoke-static {p0}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->isSuccess-impl(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {p1, p0}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 336
    :cond_0
    return-object p0
.end method

.method public static final recover-mF4-cRc(Ljava/lang/Object;Lkotlin/jvm/functions/Function1;)Ljava/lang/Object;
    .locals 6
    .param p0, "$this$recover_u2dmF4_u2dcRc"    # Ljava/lang/Object;
    .param p1, "transform"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<R:",
            "Ljava/lang/Object;",
            "T::TR;>(",
            "Ljava/lang/Object;",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Lcom/rokid/glasses/transport/sdk/api/callback/IException;",
            "+TR;>;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    const-string v0, "transform"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const/4 v0, 0x0

    .line 281
    .local v0, "$i$f$recover-mF4-cRc":I
    nop

    .line 284
    invoke-static {p0}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->exceptionOrNull-impl(Ljava/lang/Object;)Lcom/rokid/glasses/transport/sdk/api/callback/IException;

    move-result-object v1

    .line 285
    .local v1, "exception":Lcom/rokid/glasses/transport/sdk/api/callback/IException;
    if-nez v1, :cond_0

    move-object v5, p0

    goto :goto_0

    .line 286
    :cond_0
    sget-object v2, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->Companion:Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;

    .local v2, "this_$iv":Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;
    invoke-interface {p1, v1}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    .local v3, "value$iv":Ljava/lang/Object;
    const/4 v4, 0x0

    .line 349
    .local v4, "$i$f$success":I
    invoke-static {v3}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    .line 284
    .end local v1    # "exception":Lcom/rokid/glasses/transport/sdk/api/callback/IException;
    .end local v2    # "this_$iv":Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;
    .end local v3    # "value$iv":Ljava/lang/Object;
    .end local v4    # "$i$f$success":I
    :goto_0
    return-object v5
.end method

.method public static final recoverCatching-mF4-cRc(Ljava/lang/Object;Lkotlin/jvm/functions/Function1;)Ljava/lang/Object;
    .locals 8
    .param p0, "$this$recoverCatching_u2dmF4_u2dcRc"    # Ljava/lang/Object;
    .param p1, "transform"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<R:",
            "Ljava/lang/Object;",
            "T::TR;>(",
            "Ljava/lang/Object;",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Lcom/rokid/glasses/transport/sdk/api/callback/IException;",
            "+TR;>;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    const-string v0, "transform"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const/4 v0, 0x0

    .line 301
    .local v0, "$i$f$recoverCatching-mF4-cRc":I
    invoke-static {p0}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->exceptionOrNull-impl(Ljava/lang/Object;)Lcom/rokid/glasses/transport/sdk/api/callback/IException;

    move-result-object v1

    .line 302
    .local v1, "exception":Lcom/rokid/glasses/transport/sdk/api/callback/IException;
    if-nez v1, :cond_0

    move-object v7, p0

    goto :goto_1

    .line 303
    :cond_0
    move-object v2, p0

    .local v2, "$this$runCatching$iv":Ljava/lang/Object;
    const/4 v3, 0x0

    .line 350
    .local v3, "$i$f$runCatching":I
    nop

    .line 351
    :try_start_0
    sget-object v4, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->Companion:Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;

    move-object v5, v2

    .local v5, "$this$recoverCatching_mF4_cRc_u24lambda_u245":Ljava/lang/Object;
    const/4 v6, 0x0

    .line 303
    .local v6, "$i$a$-runCatching-IResultKt$recoverCatching$1":I
    invoke-interface {p1, v1}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    .line 351
    .end local v5    # "$this$recoverCatching_mF4_cRc_u24lambda_u245":Ljava/lang/Object;
    .end local v6    # "$i$a$-runCatching-IResultKt$recoverCatching$1":I
    move-object v5, v7

    .local v4, "this_$iv$iv":Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;
    .local v5, "value$iv$iv":Ljava/lang/Object;
    const/4 v6, 0x0

    .line 352
    .local v6, "$i$f$success":I
    invoke-static {v5}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7
    :try_end_0
    .catch Lcom/rokid/glasses/transport/sdk/api/callback/IException; {:try_start_0 .. :try_end_0} :catch_0

    .end local v4    # "this_$iv$iv":Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;
    .end local v5    # "value$iv$iv":Ljava/lang/Object;
    .end local v6    # "$i$f$success":I
    goto :goto_0

    .line 353
    :catch_0
    move-exception v4

    .line 354
    .local v4, "e$iv":Lcom/rokid/glasses/transport/sdk/api/callback/IException;
    sget-object v5, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->Companion:Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;

    .local v5, "this_$iv$iv":Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;
    const/4 v6, 0x0

    .line 355
    .local v6, "$i$f$failure":I
    invoke-static {v4}, Lcom/rokid/glasses/transport/sdk/api/callback/IResultKt;->createFailure(Lcom/rokid/glasses/transport/sdk/api/callback/IException;)Ljava/lang/Object;

    move-result-object v7

    invoke-static {v7}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    .line 350
    .end local v4    # "e$iv":Lcom/rokid/glasses/transport/sdk/api/callback/IException;
    .end local v5    # "this_$iv$iv":Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;
    .end local v6    # "$i$f$failure":I
    :goto_0
    nop

    .line 301
    .end local v1    # "exception":Lcom/rokid/glasses/transport/sdk/api/callback/IException;
    .end local v2    # "$this$runCatching$iv":Ljava/lang/Object;
    .end local v3    # "$i$f$runCatching":I
    :goto_1
    return-object v7
.end method

.method public static final runCatching(Ljava/lang/Object;Lkotlin/jvm/functions/Function1;)Ljava/lang/Object;
    .locals 5
    .param p0, "$this$runCatching"    # Ljava/lang/Object;
    .param p1, "block"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            "R:",
            "Ljava/lang/Object;",
            ">(TT;",
            "Lkotlin/jvm/functions/Function1<",
            "-TT;+TR;>;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    const-string v0, "block"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const/4 v0, 0x0

    .line 147
    .local v0, "$i$f$runCatching":I
    nop

    .line 148
    :try_start_0
    sget-object v1, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->Companion:Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;

    invoke-interface {p1, p0}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    .local v1, "this_$iv":Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;
    .local v2, "value$iv":Ljava/lang/Object;
    const/4 v3, 0x0

    .line 340
    .local v3, "$i$f$success":I
    invoke-static {v2}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4
    :try_end_0
    .catch Lcom/rokid/glasses/transport/sdk/api/callback/IException; {:try_start_0 .. :try_end_0} :catch_0

    .end local v1    # "this_$iv":Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;
    .end local v2    # "value$iv":Ljava/lang/Object;
    .end local v3    # "$i$f$success":I
    goto :goto_0

    .line 149
    :catch_0
    move-exception v1

    .line 150
    .local v1, "e":Lcom/rokid/glasses/transport/sdk/api/callback/IException;
    sget-object v2, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->Companion:Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;

    .local v2, "this_$iv":Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;
    const/4 v3, 0x0

    .line 341
    .local v3, "$i$f$failure":I
    invoke-static {v1}, Lcom/rokid/glasses/transport/sdk/api/callback/IResultKt;->createFailure(Lcom/rokid/glasses/transport/sdk/api/callback/IException;)Ljava/lang/Object;

    move-result-object v4

    invoke-static {v4}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    .line 147
    .end local v1    # "e":Lcom/rokid/glasses/transport/sdk/api/callback/IException;
    .end local v2    # "this_$iv":Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;
    .end local v3    # "$i$f$failure":I
    :goto_0
    return-object v4
.end method

.method public static final runCatching(Lkotlin/jvm/functions/Function0;)Ljava/lang/Object;
    .locals 5
    .param p0, "block"    # Lkotlin/jvm/functions/Function0;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<R:",
            "Ljava/lang/Object;",
            ">(",
            "Lkotlin/jvm/functions/Function0<",
            "+TR;>;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    const-string v0, "block"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const/4 v0, 0x0

    .line 133
    .local v0, "$i$f$runCatching":I
    nop

    .line 134
    :try_start_0
    sget-object v1, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->Companion:Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;

    invoke-interface {p0}, Lkotlin/jvm/functions/Function0;->invoke()Ljava/lang/Object;

    move-result-object v2

    .local v1, "this_$iv":Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;
    .local v2, "value$iv":Ljava/lang/Object;
    const/4 v3, 0x0

    .line 338
    .local v3, "$i$f$success":I
    invoke-static {v2}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4
    :try_end_0
    .catch Lcom/rokid/glasses/transport/sdk/api/callback/IException; {:try_start_0 .. :try_end_0} :catch_0

    .end local v1    # "this_$iv":Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;
    .end local v2    # "value$iv":Ljava/lang/Object;
    .end local v3    # "$i$f$success":I
    goto :goto_0

    .line 135
    :catch_0
    move-exception v1

    .line 136
    .local v1, "e":Lcom/rokid/glasses/transport/sdk/api/callback/IException;
    sget-object v2, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->Companion:Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;

    .local v2, "this_$iv":Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;
    const/4 v3, 0x0

    .line 339
    .local v3, "$i$f$failure":I
    invoke-static {v1}, Lcom/rokid/glasses/transport/sdk/api/callback/IResultKt;->createFailure(Lcom/rokid/glasses/transport/sdk/api/callback/IException;)Ljava/lang/Object;

    move-result-object v4

    invoke-static {v4}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    .line 133
    .end local v1    # "e":Lcom/rokid/glasses/transport/sdk/api/callback/IException;
    .end local v2    # "this_$iv":Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;
    .end local v3    # "$i$f$failure":I
    :goto_0
    return-object v4
.end method

.method public static final throwOnFailure-3CeXOB8(Ljava/lang/Object;)V
    .locals 1
    .param p0, "$this$throwOnFailure_u2d3CeXOB8"    # Ljava/lang/Object;

    .line 123
    instance-of v0, p0, Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Failure;

    if-nez v0, :cond_0

    .line 124
    return-void

    .line 123
    :cond_0
    move-object v0, p0

    check-cast v0, Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Failure;

    iget-object v0, v0, Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Failure;->exception:Lcom/rokid/glasses/transport/sdk/api/callback/IException;

    throw v0
.end method
