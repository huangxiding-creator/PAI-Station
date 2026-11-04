.class public final Lcom/rokid/security/phone/sdk/server/utils/SPUtil;
.super Ljava/lang/Object;
.source "SPUtil.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/phone/sdk/server/utils/SPUtil$Companion;
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nSPUtil.kt\nKotlin\n*S Kotlin\n*F\n+ 1 SPUtil.kt\ncom/rokid/security/phone/sdk/server/utils/SPUtil\n+ 2 SharedPreferences.kt\nandroidx/core/content/SharedPreferencesKt\n*L\n1#1,193:1\n39#2,12:194\n39#2,12:206\n39#2,12:218\n39#2,12:230\n39#2,12:242\n39#2,12:254\n39#2,12:266\n39#2,12:278\n*S KotlinDebug\n*F\n+ 1 SPUtil.kt\ncom/rokid/security/phone/sdk/server/utils/SPUtil\n*L\n42#1:194,12\n56#1:206,12\n70#1:218,12\n84#1:230,12\n98#1:242,12\n112#1:254,12\n130#1:266,12\n137#1:278,12\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000V\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0002\u0010\u000b\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0002\n\u0002\u0010\u0002\n\u0002\u0008\u0003\n\u0002\u0010\u0007\n\u0000\n\u0002\u0010\u0008\n\u0000\n\u0002\u0010 \n\u0000\n\u0002\u0010\t\n\u0002\u0008\u0002\n\u0002\u0010\"\n\u0002\u0008\r\u0018\u0000 +2\u00020\u0001:\u0001+B\u000f\u0008\u0002\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0002\u0010\u0004J&\u0010\u000b\u001a\u0010\u0012\u0006\u0012\u0004\u0018\u00010\u0001\u0012\u0004\u0012\u00020\r0\u000c2\u0006\u0010\u000e\u001a\u00020\u000f2\u0008\u0008\u0002\u0010\u0010\u001a\u00020\rJ\u0006\u0010\u0011\u001a\u00020\u0012J\u000e\u0010\u0013\u001a\u00020\r2\u0006\u0010\u000e\u001a\u00020\u000fJ\u0018\u0010\u0014\u001a\u00020\r2\u0006\u0010\u000e\u001a\u00020\u000f2\u0008\u0008\u0002\u0010\u0010\u001a\u00020\rJ\u0018\u0010\u0015\u001a\u00020\u00162\u0006\u0010\u000e\u001a\u00020\u000f2\u0008\u0008\u0002\u0010\u0010\u001a\u00020\u0016J\u0018\u0010\u0017\u001a\u00020\u00182\u0006\u0010\u000e\u001a\u00020\u000f2\u0008\u0008\u0002\u0010\u0010\u001a\u00020\u0018J\u000c\u0010\u0019\u001a\u0008\u0012\u0004\u0012\u00020\u000f0\u001aJ\u0018\u0010\u001b\u001a\u00020\u001c2\u0006\u0010\u000e\u001a\u00020\u000f2\u0008\u0008\u0002\u0010\u0010\u001a\u00020\u001cJ\u0018\u0010\u001d\u001a\u00020\u000f2\u0006\u0010\u000e\u001a\u00020\u000f2\u0008\u0008\u0002\u0010\u0010\u001a\u00020\u000fJ$\u0010\u001e\u001a\u0008\u0012\u0004\u0012\u00020\u000f0\u001f2\u0006\u0010\u000e\u001a\u00020\u000f2\u000e\u0008\u0002\u0010\u0010\u001a\u0008\u0012\u0004\u0012\u00020\u000f0\u001fJ\u0016\u0010 \u001a\u00020\u00122\u0006\u0010\u000e\u001a\u00020\u000f2\u0006\u0010!\u001a\u00020\rJ\u0016\u0010\"\u001a\u00020\u00122\u0006\u0010\u000e\u001a\u00020\u000f2\u0006\u0010!\u001a\u00020\u0016J\u0016\u0010#\u001a\u00020\u00122\u0006\u0010\u000e\u001a\u00020\u000f2\u0006\u0010!\u001a\u00020\u0018J\u0016\u0010$\u001a\u00020\u00122\u0006\u0010\u000e\u001a\u00020\u000f2\u0006\u0010!\u001a\u00020\u001cJ\u0016\u0010%\u001a\u00020\u00122\u0006\u0010\u000e\u001a\u00020\u000f2\u0006\u0010!\u001a\u00020\u000fJ\u001c\u0010&\u001a\u00020\u00122\u0006\u0010\u000e\u001a\u00020\u000f2\u000c\u0010!\u001a\u0008\u0012\u0004\u0012\u00020\u000f0\u001fJ\u000e\u0010\'\u001a\u00020\u00122\u0006\u0010\u000e\u001a\u00020\u000fJ\u0014\u0010(\u001a\u00020\u00122\u000c\u0010)\u001a\u0008\u0012\u0004\u0012\u00020\u000f0\u001aJ&\u0010*\u001a\u0010\u0012\u0006\u0012\u0004\u0018\u00010\u0001\u0012\u0004\u0012\u00020\u000f0\u000c2\u0006\u0010\u000e\u001a\u00020\u000f2\u0008\u0008\u0002\u0010\u0010\u001a\u00020\u000fR\u001b\u0010\u0005\u001a\u00020\u00068BX\u0082\u0084\u0002\u00a2\u0006\u000c\n\u0004\u0008\t\u0010\n\u001a\u0004\u0008\u0007\u0010\u0008\u00a8\u0006,"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/utils/SPUtil;",
        "",
        "context",
        "Landroid/content/Context;",
        "(Landroid/content/Context;)V",
        "sp",
        "Landroid/content/SharedPreferences;",
        "getSp",
        "()Landroid/content/SharedPreferences;",
        "sp$delegate",
        "Lkotlin/Lazy;",
        "booleanPreference",
        "Lkotlin/properties/ReadWriteProperty;",
        "",
        "key",
        "",
        "defaultValue",
        "clear",
        "",
        "contains",
        "getBoolean",
        "getFloat",
        "",
        "getInt",
        "",
        "getListFromPreferences",
        "",
        "getLong",
        "",
        "getString",
        "getStringSet",
        "",
        "putBoolean",
        "value",
        "putFloat",
        "putInt",
        "putLong",
        "putString",
        "putStringSet",
        "remove",
        "saveListToPreferences",
        "list",
        "stringPreference",
        "Companion",
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
.field public static final Companion:Lcom/rokid/security/phone/sdk/server/utils/SPUtil$Companion;

.field private static final KEY_APPS_LIST:Ljava/lang/String; = "apps_list"

.field private static final SP_NAME:Ljava/lang/String; = "app_shared_prefs"

.field private static volatile instance:Lcom/rokid/security/phone/sdk/server/utils/SPUtil;


# instance fields
.field private final sp$delegate:Lkotlin/Lazy;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Lcom/rokid/security/phone/sdk/server/utils/SPUtil$Companion;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/rokid/security/phone/sdk/server/utils/SPUtil$Companion;-><init>(Lkotlin/jvm/internal/DefaultConstructorMarker;)V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/utils/SPUtil;->Companion:Lcom/rokid/security/phone/sdk/server/utils/SPUtil$Companion;

    return-void
.end method

.method private constructor <init>(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .line 13
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 32
    new-instance v0, Lcom/rokid/security/phone/sdk/server/utils/SPUtil$sp$2;

    invoke-direct {v0, p1}, Lcom/rokid/security/phone/sdk/server/utils/SPUtil$sp$2;-><init>(Landroid/content/Context;)V

    check-cast v0, Lkotlin/jvm/functions/Function0;

    invoke-static {v0}, Lkotlin/LazyKt;->lazy(Lkotlin/jvm/functions/Function0;)Lkotlin/Lazy;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/utils/SPUtil;->sp$delegate:Lkotlin/Lazy;

    .line 13
    return-void
.end method

.method public synthetic constructor <init>(Landroid/content/Context;Lkotlin/jvm/internal/DefaultConstructorMarker;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/utils/SPUtil;-><init>(Landroid/content/Context;)V

    return-void
.end method

.method public static final synthetic access$getInstance$cp()Lcom/rokid/security/phone/sdk/server/utils/SPUtil;
    .locals 1

    .line 13
    sget-object v0, Lcom/rokid/security/phone/sdk/server/utils/SPUtil;->instance:Lcom/rokid/security/phone/sdk/server/utils/SPUtil;

    return-object v0
.end method

.method public static final synthetic access$setInstance$cp(Lcom/rokid/security/phone/sdk/server/utils/SPUtil;)V
    .locals 0
    .param p0, "<set-?>"    # Lcom/rokid/security/phone/sdk/server/utils/SPUtil;

    .line 13
    sput-object p0, Lcom/rokid/security/phone/sdk/server/utils/SPUtil;->instance:Lcom/rokid/security/phone/sdk/server/utils/SPUtil;

    return-void
.end method

.method public static synthetic booleanPreference$default(Lcom/rokid/security/phone/sdk/server/utils/SPUtil;Ljava/lang/String;ZILjava/lang/Object;)Lkotlin/properties/ReadWriteProperty;
    .locals 0

    .line 179
    and-int/lit8 p3, p3, 0x2

    if-eqz p3, :cond_0

    const/4 p2, 0x0

    :cond_0
    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/utils/SPUtil;->booleanPreference(Ljava/lang/String;Z)Lkotlin/properties/ReadWriteProperty;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic getBoolean$default(Lcom/rokid/security/phone/sdk/server/utils/SPUtil;Ljava/lang/String;ZILjava/lang/Object;)Z
    .locals 0

    .line 62
    and-int/lit8 p3, p3, 0x2

    if-eqz p3, :cond_0

    const/4 p2, 0x0

    :cond_0
    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/utils/SPUtil;->getBoolean(Ljava/lang/String;Z)Z

    move-result p0

    return p0
.end method

.method public static synthetic getFloat$default(Lcom/rokid/security/phone/sdk/server/utils/SPUtil;Ljava/lang/String;FILjava/lang/Object;)F
    .locals 0

    .line 104
    and-int/lit8 p3, p3, 0x2

    if-eqz p3, :cond_0

    const/4 p2, 0x0

    :cond_0
    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/utils/SPUtil;->getFloat(Ljava/lang/String;F)F

    move-result p0

    return p0
.end method

.method public static synthetic getInt$default(Lcom/rokid/security/phone/sdk/server/utils/SPUtil;Ljava/lang/String;IILjava/lang/Object;)I
    .locals 0

    .line 76
    and-int/lit8 p3, p3, 0x2

    if-eqz p3, :cond_0

    const/4 p2, 0x0

    :cond_0
    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/utils/SPUtil;->getInt(Ljava/lang/String;I)I

    move-result p0

    return p0
.end method

.method public static synthetic getLong$default(Lcom/rokid/security/phone/sdk/server/utils/SPUtil;Ljava/lang/String;JILjava/lang/Object;)J
    .locals 0

    .line 90
    and-int/lit8 p4, p4, 0x2

    if-eqz p4, :cond_0

    const-wide/16 p2, 0x0

    :cond_0
    invoke-virtual {p0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/server/utils/SPUtil;->getLong(Ljava/lang/String;J)J

    move-result-wide p0

    return-wide p0
.end method

.method private final getSp()Landroid/content/SharedPreferences;
    .locals 2

    .line 32
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/utils/SPUtil;->sp$delegate:Lkotlin/Lazy;

    invoke-interface {v0}, Lkotlin/Lazy;->getValue()Ljava/lang/Object;

    move-result-object v0

    const-string v1, "<get-sp>(...)"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v0, Landroid/content/SharedPreferences;

    return-object v0
.end method

.method public static synthetic getString$default(Lcom/rokid/security/phone/sdk/server/utils/SPUtil;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)Ljava/lang/String;
    .locals 0

    .line 48
    and-int/lit8 p3, p3, 0x2

    if-eqz p3, :cond_0

    const-string p2, ""

    :cond_0
    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/utils/SPUtil;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic getStringSet$default(Lcom/rokid/security/phone/sdk/server/utils/SPUtil;Ljava/lang/String;Ljava/util/Set;ILjava/lang/Object;)Ljava/util/Set;
    .locals 0

    .line 118
    and-int/lit8 p3, p3, 0x2

    if-eqz p3, :cond_0

    invoke-static {}, Lkotlin/collections/SetsKt;->emptySet()Ljava/util/Set;

    move-result-object p2

    :cond_0
    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/utils/SPUtil;->getStringSet(Ljava/lang/String;Ljava/util/Set;)Ljava/util/Set;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic stringPreference$default(Lcom/rokid/security/phone/sdk/server/utils/SPUtil;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)Lkotlin/properties/ReadWriteProperty;
    .locals 0

    .line 165
    and-int/lit8 p3, p3, 0x2

    if-eqz p3, :cond_0

    const-string p2, ""

    :cond_0
    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/utils/SPUtil;->stringPreference(Ljava/lang/String;Ljava/lang/String;)Lkotlin/properties/ReadWriteProperty;

    move-result-object p0

    return-object p0
.end method


# virtual methods
.method public final booleanPreference(Ljava/lang/String;Z)Lkotlin/properties/ReadWriteProperty;
    .locals 1
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "defaultValue"    # Z
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Z)",
            "Lkotlin/properties/ReadWriteProperty<",
            "Ljava/lang/Object;",
            "Ljava/lang/Boolean;",
            ">;"
        }
    .end annotation

    const-string v0, "key"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 180
    new-instance v0, Lcom/rokid/security/phone/sdk/server/utils/SPUtil$booleanPreference$1;

    invoke-direct {v0, p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/utils/SPUtil$booleanPreference$1;-><init>(Lcom/rokid/security/phone/sdk/server/utils/SPUtil;Ljava/lang/String;Z)V

    check-cast v0, Lkotlin/properties/ReadWriteProperty;

    .line 188
    return-object v0
.end method

.method public final clear()V
    .locals 6

    .line 137
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/utils/SPUtil;->getSp()Landroid/content/SharedPreferences;

    move-result-object v0

    .line 278
    .local v0, "$this$edit_u24default$iv":Landroid/content/SharedPreferences;
    nop

    .line 279
    const/4 v1, 0x0

    .line 278
    .local v1, "commit$iv":Z
    const/4 v2, 0x0

    .line 282
    .local v2, "$i$f$edit":I
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    .line 283
    .local v3, "editor$iv":Landroid/content/SharedPreferences$Editor;
    const-string v4, "editor"

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    move-object v4, v3

    .local v4, "$this$clear_u24lambda_u247":Landroid/content/SharedPreferences$Editor;
    const/4 v5, 0x0

    .line 137
    .local v5, "$i$a$-edit$default-SPUtil$clear$1":I
    invoke-interface {v4}, Landroid/content/SharedPreferences$Editor;->clear()Landroid/content/SharedPreferences$Editor;

    .line 283
    .end local v4    # "$this$clear_u24lambda_u247":Landroid/content/SharedPreferences$Editor;
    .end local v5    # "$i$a$-edit$default-SPUtil$clear$1":I
    nop

    .line 284
    nop

    .line 287
    invoke-interface {v3}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 289
    nop

    .line 138
    .end local v0    # "$this$edit_u24default$iv":Landroid/content/SharedPreferences;
    .end local v1    # "commit$iv":Z
    .end local v2    # "$i$f$edit":I
    .end local v3    # "editor$iv":Landroid/content/SharedPreferences$Editor;
    return-void
.end method

.method public final contains(Ljava/lang/String;)Z
    .locals 1
    .param p1, "key"    # Ljava/lang/String;

    const-string v0, "key"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 144
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/utils/SPUtil;->getSp()Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0, p1}, Landroid/content/SharedPreferences;->contains(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public final getBoolean(Ljava/lang/String;Z)Z
    .locals 1
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "defaultValue"    # Z

    const-string v0, "key"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 63
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/utils/SPUtil;->getSp()Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0, p1, p2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    return v0
.end method

.method public final getFloat(Ljava/lang/String;F)F
    .locals 1
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "defaultValue"    # F

    const-string v0, "key"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 105
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/utils/SPUtil;->getSp()Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0, p1, p2}, Landroid/content/SharedPreferences;->getFloat(Ljava/lang/String;F)F

    move-result v0

    return v0
.end method

.method public final getInt(Ljava/lang/String;I)I
    .locals 1
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "defaultValue"    # I

    const-string v0, "key"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 77
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/utils/SPUtil;->getSp()Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0, p1, p2}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v0

    return v0
.end method

.method public final getListFromPreferences()Ljava/util/List;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 158
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/utils/SPUtil;->getSp()Landroid/content/SharedPreferences;

    move-result-object v0

    const-string v1, "apps_list"

    invoke-static {}, Lkotlin/collections/SetsKt;->emptySet()Ljava/util/Set;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getStringSet(Ljava/lang/String;Ljava/util/Set;)Ljava/util/Set;

    move-result-object v0

    if-eqz v0, :cond_0

    check-cast v0, Ljava/lang/Iterable;

    invoke-static {v0}, Lkotlin/collections/CollectionsKt;->toList(Ljava/lang/Iterable;)Ljava/util/List;

    move-result-object v0

    if-nez v0, :cond_1

    :cond_0
    invoke-static {}, Lkotlin/collections/CollectionsKt;->emptyList()Ljava/util/List;

    move-result-object v0

    :cond_1
    return-object v0
.end method

.method public final getLong(Ljava/lang/String;J)J
    .locals 2
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "defaultValue"    # J

    const-string v0, "key"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 91
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/utils/SPUtil;->getSp()Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0, p1, p2, p3}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v0

    return-wide v0
.end method

.method public final getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "defaultValue"    # Ljava/lang/String;

    const-string v0, "key"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "defaultValue"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 49
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/utils/SPUtil;->getSp()Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0, p1, p2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_0

    move-object v0, p2

    :cond_0
    return-object v0
.end method

.method public final getStringSet(Ljava/lang/String;Ljava/util/Set;)Ljava/util/Set;
    .locals 1
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "defaultValue"    # Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;)",
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    const-string v0, "key"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "defaultValue"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 119
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/utils/SPUtil;->getSp()Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0, p1, p2}, Landroid/content/SharedPreferences;->getStringSet(Ljava/lang/String;Ljava/util/Set;)Ljava/util/Set;

    move-result-object v0

    if-nez v0, :cond_0

    move-object v0, p2

    :cond_0
    return-object v0
.end method

.method public final putBoolean(Ljava/lang/String;Z)V
    .locals 6
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "value"    # Z

    const-string v0, "key"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 56
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/utils/SPUtil;->getSp()Landroid/content/SharedPreferences;

    move-result-object v0

    .line 206
    .local v0, "$this$edit_u24default$iv":Landroid/content/SharedPreferences;
    nop

    .line 207
    const/4 v1, 0x0

    .line 206
    .local v1, "commit$iv":Z
    const/4 v2, 0x0

    .line 210
    .local v2, "$i$f$edit":I
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    .line 211
    .local v3, "editor$iv":Landroid/content/SharedPreferences$Editor;
    const-string v4, "editor"

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    move-object v4, v3

    .local v4, "$this$putBoolean_u24lambda_u241":Landroid/content/SharedPreferences$Editor;
    const/4 v5, 0x0

    .line 56
    .local v5, "$i$a$-edit$default-SPUtil$putBoolean$1":I
    invoke-interface {v4, p1, p2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    .line 211
    .end local v4    # "$this$putBoolean_u24lambda_u241":Landroid/content/SharedPreferences$Editor;
    .end local v5    # "$i$a$-edit$default-SPUtil$putBoolean$1":I
    nop

    .line 212
    nop

    .line 215
    invoke-interface {v3}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 217
    nop

    .line 57
    .end local v0    # "$this$edit_u24default$iv":Landroid/content/SharedPreferences;
    .end local v1    # "commit$iv":Z
    .end local v2    # "$i$f$edit":I
    .end local v3    # "editor$iv":Landroid/content/SharedPreferences$Editor;
    return-void
.end method

.method public final putFloat(Ljava/lang/String;F)V
    .locals 6
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "value"    # F

    const-string v0, "key"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 98
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/utils/SPUtil;->getSp()Landroid/content/SharedPreferences;

    move-result-object v0

    .line 242
    .local v0, "$this$edit_u24default$iv":Landroid/content/SharedPreferences;
    nop

    .line 243
    const/4 v1, 0x0

    .line 242
    .local v1, "commit$iv":Z
    const/4 v2, 0x0

    .line 246
    .local v2, "$i$f$edit":I
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    .line 247
    .local v3, "editor$iv":Landroid/content/SharedPreferences$Editor;
    const-string v4, "editor"

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    move-object v4, v3

    .local v4, "$this$putFloat_u24lambda_u244":Landroid/content/SharedPreferences$Editor;
    const/4 v5, 0x0

    .line 98
    .local v5, "$i$a$-edit$default-SPUtil$putFloat$1":I
    invoke-interface {v4, p1, p2}, Landroid/content/SharedPreferences$Editor;->putFloat(Ljava/lang/String;F)Landroid/content/SharedPreferences$Editor;

    .line 247
    .end local v4    # "$this$putFloat_u24lambda_u244":Landroid/content/SharedPreferences$Editor;
    .end local v5    # "$i$a$-edit$default-SPUtil$putFloat$1":I
    nop

    .line 248
    nop

    .line 251
    invoke-interface {v3}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 253
    nop

    .line 99
    .end local v0    # "$this$edit_u24default$iv":Landroid/content/SharedPreferences;
    .end local v1    # "commit$iv":Z
    .end local v2    # "$i$f$edit":I
    .end local v3    # "editor$iv":Landroid/content/SharedPreferences$Editor;
    return-void
.end method

.method public final putInt(Ljava/lang/String;I)V
    .locals 6
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "value"    # I

    const-string v0, "key"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 70
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/utils/SPUtil;->getSp()Landroid/content/SharedPreferences;

    move-result-object v0

    .line 218
    .local v0, "$this$edit_u24default$iv":Landroid/content/SharedPreferences;
    nop

    .line 219
    const/4 v1, 0x0

    .line 218
    .local v1, "commit$iv":Z
    const/4 v2, 0x0

    .line 222
    .local v2, "$i$f$edit":I
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    .line 223
    .local v3, "editor$iv":Landroid/content/SharedPreferences$Editor;
    const-string v4, "editor"

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    move-object v4, v3

    .local v4, "$this$putInt_u24lambda_u242":Landroid/content/SharedPreferences$Editor;
    const/4 v5, 0x0

    .line 70
    .local v5, "$i$a$-edit$default-SPUtil$putInt$1":I
    invoke-interface {v4, p1, p2}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    .line 223
    .end local v4    # "$this$putInt_u24lambda_u242":Landroid/content/SharedPreferences$Editor;
    .end local v5    # "$i$a$-edit$default-SPUtil$putInt$1":I
    nop

    .line 224
    nop

    .line 227
    invoke-interface {v3}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 229
    nop

    .line 71
    .end local v0    # "$this$edit_u24default$iv":Landroid/content/SharedPreferences;
    .end local v1    # "commit$iv":Z
    .end local v2    # "$i$f$edit":I
    .end local v3    # "editor$iv":Landroid/content/SharedPreferences$Editor;
    return-void
.end method

.method public final putLong(Ljava/lang/String;J)V
    .locals 6
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "value"    # J

    const-string v0, "key"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 84
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/utils/SPUtil;->getSp()Landroid/content/SharedPreferences;

    move-result-object v0

    .line 230
    .local v0, "$this$edit_u24default$iv":Landroid/content/SharedPreferences;
    nop

    .line 231
    const/4 v1, 0x0

    .line 230
    .local v1, "commit$iv":Z
    const/4 v2, 0x0

    .line 234
    .local v2, "$i$f$edit":I
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    .line 235
    .local v3, "editor$iv":Landroid/content/SharedPreferences$Editor;
    const-string v4, "editor"

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    move-object v4, v3

    .local v4, "$this$putLong_u24lambda_u243":Landroid/content/SharedPreferences$Editor;
    const/4 v5, 0x0

    .line 84
    .local v5, "$i$a$-edit$default-SPUtil$putLong$1":I
    invoke-interface {v4, p1, p2, p3}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    .line 235
    .end local v4    # "$this$putLong_u24lambda_u243":Landroid/content/SharedPreferences$Editor;
    .end local v5    # "$i$a$-edit$default-SPUtil$putLong$1":I
    nop

    .line 236
    nop

    .line 239
    invoke-interface {v3}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 241
    nop

    .line 85
    .end local v0    # "$this$edit_u24default$iv":Landroid/content/SharedPreferences;
    .end local v1    # "commit$iv":Z
    .end local v2    # "$i$f$edit":I
    .end local v3    # "editor$iv":Landroid/content/SharedPreferences$Editor;
    return-void
.end method

.method public final putString(Ljava/lang/String;Ljava/lang/String;)V
    .locals 6
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/String;

    const-string v0, "key"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v0, "value"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 42
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/utils/SPUtil;->getSp()Landroid/content/SharedPreferences;

    move-result-object v0

    .line 194
    .local v0, "$this$edit_u24default$iv":Landroid/content/SharedPreferences;
    nop

    .line 195
    const/4 v1, 0x0

    .line 194
    .local v1, "commit$iv":Z
    const/4 v2, 0x0

    .line 198
    .local v2, "$i$f$edit":I
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    .line 199
    .local v3, "editor$iv":Landroid/content/SharedPreferences$Editor;
    const-string v4, "editor"

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    move-object v4, v3

    .local v4, "$this$putString_u24lambda_u240":Landroid/content/SharedPreferences$Editor;
    const/4 v5, 0x0

    .line 42
    .local v5, "$i$a$-edit$default-SPUtil$putString$1":I
    invoke-interface {v4, p1, p2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 199
    .end local v4    # "$this$putString_u24lambda_u240":Landroid/content/SharedPreferences$Editor;
    .end local v5    # "$i$a$-edit$default-SPUtil$putString$1":I
    nop

    .line 200
    nop

    .line 203
    invoke-interface {v3}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 205
    nop

    .line 43
    .end local v0    # "$this$edit_u24default$iv":Landroid/content/SharedPreferences;
    .end local v1    # "commit$iv":Z
    .end local v2    # "$i$f$edit":I
    .end local v3    # "editor$iv":Landroid/content/SharedPreferences$Editor;
    return-void
.end method

.method public final putStringSet(Ljava/lang/String;Ljava/util/Set;)V
    .locals 6
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    const-string v0, "key"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v0, "value"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 112
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/utils/SPUtil;->getSp()Landroid/content/SharedPreferences;

    move-result-object v0

    .line 254
    .local v0, "$this$edit_u24default$iv":Landroid/content/SharedPreferences;
    nop

    .line 255
    const/4 v1, 0x0

    .line 254
    .local v1, "commit$iv":Z
    const/4 v2, 0x0

    .line 258
    .local v2, "$i$f$edit":I
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    .line 259
    .local v3, "editor$iv":Landroid/content/SharedPreferences$Editor;
    const-string v4, "editor"

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    move-object v4, v3

    .local v4, "$this$putStringSet_u24lambda_u245":Landroid/content/SharedPreferences$Editor;
    const/4 v5, 0x0

    .line 112
    .local v5, "$i$a$-edit$default-SPUtil$putStringSet$1":I
    invoke-interface {v4, p1, p2}, Landroid/content/SharedPreferences$Editor;->putStringSet(Ljava/lang/String;Ljava/util/Set;)Landroid/content/SharedPreferences$Editor;

    .line 259
    .end local v4    # "$this$putStringSet_u24lambda_u245":Landroid/content/SharedPreferences$Editor;
    .end local v5    # "$i$a$-edit$default-SPUtil$putStringSet$1":I
    nop

    .line 260
    nop

    .line 263
    invoke-interface {v3}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 265
    nop

    .line 113
    .end local v0    # "$this$edit_u24default$iv":Landroid/content/SharedPreferences;
    .end local v1    # "commit$iv":Z
    .end local v2    # "$i$f$edit":I
    .end local v3    # "editor$iv":Landroid/content/SharedPreferences$Editor;
    return-void
.end method

.method public final remove(Ljava/lang/String;)V
    .locals 6
    .param p1, "key"    # Ljava/lang/String;

    const-string v0, "key"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 130
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/utils/SPUtil;->getSp()Landroid/content/SharedPreferences;

    move-result-object v0

    .line 266
    .local v0, "$this$edit_u24default$iv":Landroid/content/SharedPreferences;
    nop

    .line 267
    const/4 v1, 0x0

    .line 266
    .local v1, "commit$iv":Z
    const/4 v2, 0x0

    .line 270
    .local v2, "$i$f$edit":I
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    .line 271
    .local v3, "editor$iv":Landroid/content/SharedPreferences$Editor;
    const-string v4, "editor"

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    move-object v4, v3

    .local v4, "$this$remove_u24lambda_u246":Landroid/content/SharedPreferences$Editor;
    const/4 v5, 0x0

    .line 130
    .local v5, "$i$a$-edit$default-SPUtil$remove$1":I
    invoke-interface {v4, p1}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 271
    .end local v4    # "$this$remove_u24lambda_u246":Landroid/content/SharedPreferences$Editor;
    .end local v5    # "$i$a$-edit$default-SPUtil$remove$1":I
    nop

    .line 272
    nop

    .line 275
    invoke-interface {v3}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 277
    nop

    .line 131
    .end local v0    # "$this$edit_u24default$iv":Landroid/content/SharedPreferences;
    .end local v1    # "commit$iv":Z
    .end local v2    # "$i$f$edit":I
    .end local v3    # "editor$iv":Landroid/content/SharedPreferences$Editor;
    return-void
.end method

.method public final saveListToPreferences(Ljava/util/List;)V
    .locals 3
    .param p1, "list"    # Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    const-string v0, "list"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 153
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/utils/SPUtil;->getSp()Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    move-object v1, p1

    check-cast v1, Ljava/lang/Iterable;

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->toSet(Ljava/lang/Iterable;)Ljava/util/Set;

    move-result-object v1

    const-string v2, "apps_list"

    invoke-interface {v0, v2, v1}, Landroid/content/SharedPreferences$Editor;->putStringSet(Ljava/lang/String;Ljava/util/Set;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 154
    return-void
.end method

.method public final stringPreference(Ljava/lang/String;Ljava/lang/String;)Lkotlin/properties/ReadWriteProperty;
    .locals 1
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "defaultValue"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ")",
            "Lkotlin/properties/ReadWriteProperty<",
            "Ljava/lang/Object;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    const-string v0, "key"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "defaultValue"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 166
    new-instance v0, Lcom/rokid/security/phone/sdk/server/utils/SPUtil$stringPreference$1;

    invoke-direct {v0, p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/utils/SPUtil$stringPreference$1;-><init>(Lcom/rokid/security/phone/sdk/server/utils/SPUtil;Ljava/lang/String;Ljava/lang/String;)V

    check-cast v0, Lkotlin/properties/ReadWriteProperty;

    .line 174
    return-object v0
.end method
