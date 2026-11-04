.class public final Lcom/rokid/security/phone/sdk/server/translate/TranslateServiceImpl;
.super Lcom/rokid/security/phone/sdk/api/translate/api/AbsTranslateService;
.source "TranslateServiceImpl.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001c\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0002\n\u0002\u0010\u0002\n\u0002\u0008\u0003\u0008\u00c0\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0008\u0010\u0003\u001a\u00020\u0004H\u0016J\u0008\u0010\u0005\u001a\u00020\u0004H\u0016J\u0018\u0010\u0006\u001a\u00020\u00072\u0006\u0010\u0008\u001a\u00020\u00042\u0006\u0010\t\u001a\u00020\u0004H\u0016\u00a8\u0006\n"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/translate/TranslateServiceImpl;",
        "Lcom/rokid/security/phone/sdk/api/translate/api/AbsTranslateService;",
        "()V",
        "getLanguageDest",
        "",
        "getLanguageSrc",
        "setLanguage",
        "",
        "src",
        "dest",
        "sdk-server_release"
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
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/translate/TranslateServiceImpl;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/translate/TranslateServiceImpl;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/translate/TranslateServiceImpl;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/translate/TranslateServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/translate/TranslateServiceImpl;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 8
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/api/translate/api/AbsTranslateService;-><init>()V

    return-void
.end method


# virtual methods
.method public getLanguageDest()Ljava/lang/String;
    .locals 1

    .line 18
    sget-object v0, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->INSTANCE:Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->getTranslateDest()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getLanguageSrc()Ljava/lang/String;
    .locals 1

    .line 14
    sget-object v0, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->INSTANCE:Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->getTranslateSrc()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public setLanguage(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "src"    # Ljava/lang/String;
    .param p2, "dest"    # Ljava/lang/String;

    const-string/jumbo v0, "src"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "dest"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 10
    sget-object v0, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->INSTANCE:Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;

    invoke-virtual {v0, p1, p2}, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->startTranslate(Ljava/lang/String;Ljava/lang/String;)V

    .line 11
    return-void
.end method
