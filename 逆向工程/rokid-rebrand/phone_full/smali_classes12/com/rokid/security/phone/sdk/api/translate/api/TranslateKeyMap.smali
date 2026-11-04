.class public final Lcom/rokid/security/phone/sdk/api/translate/api/TranslateKeyMap;
.super Ljava/lang/Object;
.source "TranslateKeyMap.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0018\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010%\n\u0002\u0010\u000e\n\u0002\u0008\u0007\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002R\u001d\u0010\u0003\u001a\u000e\u0012\u0004\u0012\u00020\u0005\u0012\u0004\u0012\u00020\u00050\u0004\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0006\u0010\u0007R\u001d\u0010\u0008\u001a\u000e\u0012\u0004\u0012\u00020\u0005\u0012\u0004\u0012\u00020\u00050\u0004\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\t\u0010\u0007R\u001d\u0010\n\u001a\u000e\u0012\u0004\u0012\u00020\u0005\u0012\u0004\u0012\u00020\u00050\u0004\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u000b\u0010\u0007\u00a8\u0006\u000c"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/api/translate/api/TranslateKeyMap;",
        "",
        "()V",
        "NormalLanguageMap",
        "",
        "",
        "getNormalLanguageMap",
        "()Ljava/util/Map;",
        "innerLanguageMap",
        "getInnerLanguageMap",
        "outLanguageMap",
        "getOutLanguageMap",
        "sdk-api_release"
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
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/api/translate/api/TranslateKeyMap;

.field private static final NormalLanguageMap:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static final innerLanguageMap:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static final outLanguageMap:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 3

    new-instance v0, Lcom/rokid/security/phone/sdk/api/translate/api/TranslateKeyMap;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/api/translate/api/TranslateKeyMap;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/api/translate/api/TranslateKeyMap;->INSTANCE:Lcom/rokid/security/phone/sdk/api/translate/api/TranslateKeyMap;

    .line 10
    new-instance v0, Ljava/util/LinkedHashMap;

    invoke-direct {v0}, Ljava/util/LinkedHashMap;-><init>()V

    check-cast v0, Ljava/util/Map;

    sput-object v0, Lcom/rokid/security/phone/sdk/api/translate/api/TranslateKeyMap;->NormalLanguageMap:Ljava/util/Map;

    .line 12
    new-instance v0, Ljava/util/LinkedHashMap;

    invoke-direct {v0}, Ljava/util/LinkedHashMap;-><init>()V

    check-cast v0, Ljava/util/Map;

    sput-object v0, Lcom/rokid/security/phone/sdk/api/translate/api/TranslateKeyMap;->innerLanguageMap:Ljava/util/Map;

    .line 14
    new-instance v0, Ljava/util/LinkedHashMap;

    invoke-direct {v0}, Ljava/util/LinkedHashMap;-><init>()V

    check-cast v0, Ljava/util/Map;

    sput-object v0, Lcom/rokid/security/phone/sdk/api/translate/api/TranslateKeyMap;->outLanguageMap:Ljava/util/Map;

    .line 17
    nop

    .line 19
    sget-object v0, Lcom/rokid/security/phone/sdk/api/translate/api/TranslateKeyMap;->NormalLanguageMap:Ljava/util/Map;

    const-string/jumbo v1, "\u4e2d\u6587"

    const-string/jumbo v2, "zh"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 20
    sget-object v0, Lcom/rokid/security/phone/sdk/api/translate/api/TranslateKeyMap;->NormalLanguageMap:Ljava/util/Map;

    const-string/jumbo v1, "\u82f1\u6587"

    const-string v2, "en"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 21
    sget-object v0, Lcom/rokid/security/phone/sdk/api/translate/api/TranslateKeyMap;->NormalLanguageMap:Ljava/util/Map;

    const-string/jumbo v1, "\u65e5\u8bed"

    const-string v2, "ja"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 22
    sget-object v0, Lcom/rokid/security/phone/sdk/api/translate/api/TranslateKeyMap;->NormalLanguageMap:Ljava/util/Map;

    const-string/jumbo v1, "\u4fc4\u8bed"

    const-string/jumbo v2, "ru"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 23
    sget-object v0, Lcom/rokid/security/phone/sdk/api/translate/api/TranslateKeyMap;->NormalLanguageMap:Ljava/util/Map;

    const-string/jumbo v1, "\u6cd5\u8bed"

    const-string v2, "fr"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 24
    sget-object v0, Lcom/rokid/security/phone/sdk/api/translate/api/TranslateKeyMap;->NormalLanguageMap:Ljava/util/Map;

    const-string/jumbo v1, "\u897f\u73ed\u7259\u8bed"

    const-string v2, "es"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 27
    sget-object v0, Lcom/rokid/security/phone/sdk/api/translate/api/TranslateKeyMap;->innerLanguageMap:Ljava/util/Map;

    sget-object v1, Lcom/rokid/security/phone/sdk/api/translate/api/TranslateKeyMap;->NormalLanguageMap:Ljava/util/Map;

    invoke-interface {v0, v1}, Ljava/util/Map;->putAll(Ljava/util/Map;)V

    .line 28
    sget-object v0, Lcom/rokid/security/phone/sdk/api/translate/api/TranslateKeyMap;->innerLanguageMap:Ljava/util/Map;

    const-string/jumbo v1, "\u7ef4\u8bed"

    const-string/jumbo v2, "ug"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 29
    sget-object v0, Lcom/rokid/security/phone/sdk/api/translate/api/TranslateKeyMap;->innerLanguageMap:Ljava/util/Map;

    const-string/jumbo v1, "\u963f\u62c9\u4f2f\u8bed"

    const-string v2, "ar"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 30
    sget-object v0, Lcom/rokid/security/phone/sdk/api/translate/api/TranslateKeyMap;->innerLanguageMap:Ljava/util/Map;

    const-string/jumbo v1, "\u6cf0\u8bed"

    const-string/jumbo v2, "th"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 31
    sget-object v0, Lcom/rokid/security/phone/sdk/api/translate/api/TranslateKeyMap;->innerLanguageMap:Ljava/util/Map;

    const-string/jumbo v1, "\u8d8a\u5357\u8bed"

    const-string/jumbo v2, "vi"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 34
    sget-object v0, Lcom/rokid/security/phone/sdk/api/translate/api/TranslateKeyMap;->outLanguageMap:Ljava/util/Map;

    sget-object v1, Lcom/rokid/security/phone/sdk/api/translate/api/TranslateKeyMap;->NormalLanguageMap:Ljava/util/Map;

    invoke-interface {v0, v1}, Ljava/util/Map;->putAll(Ljava/util/Map;)V

    .line 35
    sget-object v0, Lcom/rokid/security/phone/sdk/api/translate/api/TranslateKeyMap;->outLanguageMap:Ljava/util/Map;

    const-string/jumbo v1, "\u7ca4\u8bed"

    const-string/jumbo v2, "yue"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 36
    sget-object v0, Lcom/rokid/security/phone/sdk/api/translate/api/TranslateKeyMap;->outLanguageMap:Ljava/util/Map;

    const-string/jumbo v1, "\u97e9\u8bed"

    const-string v2, "ko"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 37
    sget-object v0, Lcom/rokid/security/phone/sdk/api/translate/api/TranslateKeyMap;->outLanguageMap:Ljava/util/Map;

    const-string/jumbo v1, "\u5fb7\u8bed"

    const-string v2, "de"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 38
    sget-object v0, Lcom/rokid/security/phone/sdk/api/translate/api/TranslateKeyMap;->outLanguageMap:Ljava/util/Map;

    const-string/jumbo v1, "\u610f\u5927\u5229\u8bed"

    const-string v2, "it"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 44
    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 7
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final getInnerLanguageMap()Ljava/util/Map;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 12
    sget-object v0, Lcom/rokid/security/phone/sdk/api/translate/api/TranslateKeyMap;->innerLanguageMap:Ljava/util/Map;

    return-object v0
.end method

.method public final getNormalLanguageMap()Ljava/util/Map;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 10
    sget-object v0, Lcom/rokid/security/phone/sdk/api/translate/api/TranslateKeyMap;->NormalLanguageMap:Ljava/util/Map;

    return-object v0
.end method

.method public final getOutLanguageMap()Ljava/util/Map;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 14
    sget-object v0, Lcom/rokid/security/phone/sdk/api/translate/api/TranslateKeyMap;->outLanguageMap:Ljava/util/Map;

    return-object v0
.end method
