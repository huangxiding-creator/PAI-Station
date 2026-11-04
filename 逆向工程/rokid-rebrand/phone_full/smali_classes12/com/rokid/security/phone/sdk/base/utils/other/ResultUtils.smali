.class public final Lcom/rokid/security/phone/sdk/base/utils/other/ResultUtils;
.super Ljava/lang/Object;
.source "ResultUtils.kt"


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nResultUtils.kt\nKotlin\n*S Kotlin\n*F\n+ 1 ResultUtils.kt\ncom/rokid/security/phone/sdk/base/utils/other/ResultUtils\n+ 2 IResult.kt\ncom/rokid/security/phone/sdk/base/data/callback/IResult$Companion\n*L\n1#1,28:1\n93#2:29\n93#2:30\n93#2:31\n*S KotlinDebug\n*F\n+ 1 ResultUtils.kt\ncom/rokid/security/phone/sdk/base/utils/other/ResultUtils\n*L\n15#1:29\n20#1:30\n24#1:31\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000*\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0010\u0008\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0003\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J,\u0010\u0003\u001a\u0008\u0012\u0004\u0012\u0002H\u00050\u0004\"\u0004\u0008\u0000\u0010\u00052\u0008\u0010\u0006\u001a\u0004\u0018\u00010\u0007\u00f8\u0001\u0000\u00f8\u0001\u0001\u00f8\u0001\u0002\u00a2\u0006\u0004\u0008\u0008\u0010\tJ2\u0010\u0003\u001a\u0008\u0012\u0004\u0012\u0002H\u00050\u0004\"\u0004\u0008\u0000\u0010\u00052\u0006\u0010\n\u001a\u00020\u000b2\u0006\u0010\u000c\u001a\u00020\r\u00f8\u0001\u0000\u00f8\u0001\u0001\u00f8\u0001\u0002\u00a2\u0006\u0004\u0008\u000e\u0010\u000f\u0082\u0002\u000f\n\u0002\u0008!\n\u0005\u0008\u00a1\u001e0\u0001\n\u0002\u0008\u0019\u00a8\u0006\u0010"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/base/utils/other/ResultUtils;",
        "",
        "()V",
        "getIFailResult",
        "Lcom/rokid/security/phone/sdk/base/data/callback/IResult;",
        "T",
        "exception",
        "Lcom/rokid/security/phone/sdk/base/data/callback/IException;",
        "getIFailResult-vOxm6RA",
        "(Lcom/rokid/security/phone/sdk/base/data/callback/IException;)Ljava/lang/Object;",
        "errorCode",
        "",
        "msg",
        "",
        "getIFailResult-GMMPgog",
        "(ILjava/lang/String;)Ljava/lang/Object;",
        "base-utils_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# static fields
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/base/utils/other/ResultUtils;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/base/utils/other/ResultUtils;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/base/utils/other/ResultUtils;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/base/utils/other/ResultUtils;->INSTANCE:Lcom/rokid/security/phone/sdk/base/utils/other/ResultUtils;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 10
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final getIFailResult-GMMPgog(ILjava/lang/String;)Ljava/lang/Object;
    .locals 9
    .param p1, "errorCode"    # I
    .param p2, "msg"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(I",
            "Ljava/lang/String;",
            ")",
            "Ljava/lang/Object;"
        }
    .end annotation

    const-string v0, "msg"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 13
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "errorCode= "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ",  msg = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x20

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 14
    .local v0, "erroeMsg":Ljava/lang/String;
    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 15
    sget-object v7, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->Companion:Lcom/rokid/security/phone/sdk/base/data/callback/IResult$Companion;

    .local v7, "this_$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IResult$Companion;
    new-instance v8, Lcom/rokid/security/phone/sdk/base/data/callback/IException;

    const/4 v5, 0x4

    const/4 v6, 0x0

    const/4 v4, 0x0

    move-object v1, v8

    move v2, p1

    move-object v3, v0

    invoke-direct/range {v1 .. v6}, Lcom/rokid/security/phone/sdk/base/data/callback/IException;-><init>(ILjava/lang/String;Ljava/lang/Throwable;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    .local v1, "exception$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IException;
    const/4 v2, 0x0

    .line 29
    .local v2, "$i$f$failure":I
    invoke-static {v1}, Lcom/rokid/security/phone/sdk/base/data/callback/IResultKt;->createFailure(Lcom/rokid/security/phone/sdk/base/data/callback/IException;)Ljava/lang/Object;

    move-result-object v3

    invoke-static {v3}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    .line 15
    .end local v1    # "exception$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IException;
    .end local v2    # "$i$f$failure":I
    .end local v7    # "this_$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IResult$Companion;
    return-object v1
.end method

.method public final getIFailResult-vOxm6RA(Lcom/rokid/security/phone/sdk/base/data/callback/IException;)Ljava/lang/Object;
    .locals 8
    .param p1, "exception"    # Lcom/rokid/security/phone/sdk/base/data/callback/IException;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Lcom/rokid/security/phone/sdk/base/data/callback/IException;",
            ")",
            "Ljava/lang/Object;"
        }
    .end annotation

    .line 19
    if-nez p1, :cond_0

    .line 20
    sget-object v0, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->Companion:Lcom/rokid/security/phone/sdk/base/data/callback/IResult$Companion;

    .local v0, "this_$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IResult$Companion;
    new-instance v7, Lcom/rokid/security/phone/sdk/base/data/callback/IException;

    const/4 v5, 0x4

    const/4 v6, 0x0

    const/4 v2, -0x1

    const-string v3, ""

    const/4 v4, 0x0

    move-object v1, v7

    invoke-direct/range {v1 .. v6}, Lcom/rokid/security/phone/sdk/base/data/callback/IException;-><init>(ILjava/lang/String;Ljava/lang/Throwable;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    .local v1, "exception$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IException;
    const/4 v2, 0x0

    .line 30
    .local v2, "$i$f$failure":I
    invoke-static {v1}, Lcom/rokid/security/phone/sdk/base/data/callback/IResultKt;->createFailure(Lcom/rokid/security/phone/sdk/base/data/callback/IException;)Ljava/lang/Object;

    move-result-object v3

    invoke-static {v3}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 20
    .end local v0    # "this_$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IResult$Companion;
    .end local v1    # "exception$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IException;
    .end local v2    # "$i$f$failure":I
    return-object v0

    .line 22
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "errorCode= $"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p1}, Lcom/rokid/security/phone/sdk/base/data/callback/IException;->getCode()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ",  msg = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p1}, Lcom/rokid/security/phone/sdk/base/data/callback/IException;->getMessage()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x20

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 23
    .local v0, "erroeMsg":Ljava/lang/String;
    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 24
    sget-object v1, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->Companion:Lcom/rokid/security/phone/sdk/base/data/callback/IResult$Companion;

    .local v1, "this_$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IResult$Companion;
    const/4 v2, 0x0

    .line 31
    .restart local v2    # "$i$f$failure":I
    invoke-static {p1}, Lcom/rokid/security/phone/sdk/base/data/callback/IResultKt;->createFailure(Lcom/rokid/security/phone/sdk/base/data/callback/IException;)Ljava/lang/Object;

    move-result-object v3

    invoke-static {v3}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    .line 24
    .end local v1    # "this_$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IResult$Companion;
    .end local v2    # "$i$f$failure":I
    return-object v1
.end method
