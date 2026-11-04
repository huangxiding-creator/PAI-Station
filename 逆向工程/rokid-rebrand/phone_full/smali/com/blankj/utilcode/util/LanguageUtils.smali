.class public Lcom/blankj/utilcode/util/LanguageUtils;
.super Ljava/lang/Object;
.source "LanguageUtils.java"


# static fields
.field private static final KEY_LOCALE:Ljava/lang/String; = "KEY_LOCALE"

.field private static final VALUE_FOLLOW_SYSTEM:Ljava/lang/String; = "VALUE_FOLLOW_SYSTEM"


# direct methods
.method private constructor <init>()V
    .locals 2

    .line 29
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 30
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    const-string/jumbo v1, "u can\'t instantiate me..."

    invoke-direct {v0, v1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method static synthetic access$000(Z)V
    .locals 0
    .param p0, "x0"    # Z

    .line 24
    invoke-static {p0}, Lcom/blankj/utilcode/util/LanguageUtils;->restart(Z)V

    return-void
.end method

.method static applyLanguage(Landroid/app/Activity;)V
    .locals 3
    .param p0, "activity"    # Landroid/app/Activity;

    .line 231
    invoke-static {}, Lcom/blankj/utilcode/util/UtilsBridge;->getSpUtils4Utils()Lcom/blankj/utilcode/util/SPUtils;

    move-result-object v0

    const-string v1, "KEY_LOCALE"

    invoke-virtual {v0, v1}, Lcom/blankj/utilcode/util/SPUtils;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 232
    .local v0, "spLocale":Ljava/lang/String;
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 233
    return-void

    .line 237
    :cond_0
    const-string v1, "VALUE_FOLLOW_SYSTEM"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 238
    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v1

    invoke-static {v1}, Lcom/blankj/utilcode/util/LanguageUtils;->getLocal(Landroid/content/res/Configuration;)Ljava/util/Locale;

    move-result-object v1

    .local v1, "destLocal":Ljava/util/Locale;
    goto :goto_0

    .line 240
    .end local v1    # "destLocal":Ljava/util/Locale;
    :cond_1
    invoke-static {v0}, Lcom/blankj/utilcode/util/LanguageUtils;->string2Locale(Ljava/lang/String;)Ljava/util/Locale;

    move-result-object v1

    .line 243
    .restart local v1    # "destLocal":Ljava/util/Locale;
    :goto_0
    if-nez v1, :cond_2

    return-void

    .line 245
    :cond_2
    invoke-static {p0, v1}, Lcom/blankj/utilcode/util/LanguageUtils;->updateConfiguration(Landroid/content/Context;Ljava/util/Locale;)V

    .line 246
    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v2

    invoke-static {v2, v1}, Lcom/blankj/utilcode/util/LanguageUtils;->updateConfiguration(Landroid/content/Context;Ljava/util/Locale;)V

    .line 247
    return-void
.end method

.method public static applyLanguage(Ljava/util/Locale;)V
    .locals 1
    .param p0, "locale"    # Ljava/util/Locale;

    .line 55
    const/4 v0, 0x0

    invoke-static {p0, v0}, Lcom/blankj/utilcode/util/LanguageUtils;->applyLanguage(Ljava/util/Locale;Z)V

    .line 56
    return-void
.end method

.method public static applyLanguage(Ljava/util/Locale;Z)V
    .locals 0
    .param p0, "locale"    # Ljava/util/Locale;
    .param p1, "isRelaunchApp"    # Z

    .line 66
    invoke-static {p0, p1}, Lcom/blankj/utilcode/util/LanguageUtils;->applyLanguageReal(Ljava/util/Locale;Z)V

    .line 67
    return-void
.end method

.method private static applyLanguageReal(Ljava/util/Locale;Z)V
    .locals 4
    .param p0, "locale"    # Ljava/util/Locale;
    .param p1, "isRelaunchApp"    # Z

    .line 71
    const/4 v0, 0x1

    const-string v1, "KEY_LOCALE"

    if-nez p0, :cond_0

    .line 72
    invoke-static {}, Lcom/blankj/utilcode/util/UtilsBridge;->getSpUtils4Utils()Lcom/blankj/utilcode/util/SPUtils;

    move-result-object v2

    const-string v3, "VALUE_FOLLOW_SYSTEM"

    invoke-virtual {v2, v1, v3, v0}, Lcom/blankj/utilcode/util/SPUtils;->put(Ljava/lang/String;Ljava/lang/String;Z)V

    goto :goto_0

    .line 74
    :cond_0
    invoke-static {}, Lcom/blankj/utilcode/util/UtilsBridge;->getSpUtils4Utils()Lcom/blankj/utilcode/util/SPUtils;

    move-result-object v2

    invoke-static {p0}, Lcom/blankj/utilcode/util/LanguageUtils;->locale2String(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v1, v3, v0}, Lcom/blankj/utilcode/util/SPUtils;->put(Ljava/lang/String;Ljava/lang/String;Z)V

    .line 77
    :goto_0
    if-nez p0, :cond_1

    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    invoke-static {v0}, Lcom/blankj/utilcode/util/LanguageUtils;->getLocal(Landroid/content/res/Configuration;)Ljava/util/Locale;

    move-result-object v0

    goto :goto_1

    :cond_1
    move-object v0, p0

    .line 78
    .local v0, "destLocal":Ljava/util/Locale;
    :goto_1
    new-instance v1, Lcom/blankj/utilcode/util/LanguageUtils$1;

    invoke-direct {v1, p1}, Lcom/blankj/utilcode/util/LanguageUtils$1;-><init>(Z)V

    invoke-static {v0, v1}, Lcom/blankj/utilcode/util/LanguageUtils;->updateAppContextLanguage(Ljava/util/Locale;Lcom/blankj/utilcode/util/Utils$Consumer;)V

    .line 89
    return-void
.end method

.method public static applySystemLanguage()V
    .locals 1

    .line 37
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/blankj/utilcode/util/LanguageUtils;->applySystemLanguage(Z)V

    .line 38
    return-void
.end method

.method public static applySystemLanguage(Z)V
    .locals 1
    .param p0, "isRelaunchApp"    # Z

    .line 46
    const/4 v0, 0x0

    invoke-static {v0, p0}, Lcom/blankj/utilcode/util/LanguageUtils;->applyLanguageReal(Ljava/util/Locale;Z)V

    .line 47
    return-void
.end method

.method public static attachBaseContext(Landroid/content/Context;)Landroid/content/Context;
    .locals 5
    .param p0, "context"    # Landroid/content/Context;

    .line 209
    invoke-static {}, Lcom/blankj/utilcode/util/UtilsBridge;->getSpUtils4Utils()Lcom/blankj/utilcode/util/SPUtils;

    move-result-object v0

    const-string v1, "KEY_LOCALE"

    invoke-virtual {v0, v1}, Lcom/blankj/utilcode/util/SPUtils;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 210
    .local v0, "spLocaleStr":Ljava/lang/String;
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_2

    const-string v1, "VALUE_FOLLOW_SYSTEM"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    goto :goto_0

    .line 214
    :cond_0
    invoke-static {v0}, Lcom/blankj/utilcode/util/LanguageUtils;->string2Locale(Ljava/lang/String;)Ljava/util/Locale;

    move-result-object v1

    .line 215
    .local v1, "settingsLocale":Ljava/util/Locale;
    if-nez v1, :cond_1

    return-object p0

    .line 217
    :cond_1
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    .line 218
    .local v2, "resources":Landroid/content/res/Resources;
    invoke-virtual {v2}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v3

    .line 220
    .local v3, "config":Landroid/content/res/Configuration;
    invoke-static {v3, v1}, Lcom/blankj/utilcode/util/LanguageUtils;->setLocal(Landroid/content/res/Configuration;Ljava/util/Locale;)V

    .line 222
    nop

    .line 223
    invoke-virtual {p0, v3}, Landroid/content/Context;->createConfigurationContext(Landroid/content/res/Configuration;)Landroid/content/Context;

    move-result-object v4

    return-object v4

    .line 211
    .end local v1    # "settingsLocale":Ljava/util/Locale;
    .end local v2    # "resources":Landroid/content/res/Resources;
    .end local v3    # "config":Landroid/content/res/Configuration;
    :cond_2
    :goto_0
    return-object p0
.end method

.method public static getAppContextLanguage()Ljava/util/Locale;
    .locals 1

    .line 152
    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v0

    invoke-static {v0}, Lcom/blankj/utilcode/util/LanguageUtils;->getContextLanguage(Landroid/content/Context;)Ljava/util/Locale;

    move-result-object v0

    return-object v0
.end method

.method public static getAppliedLanguage()Ljava/util/Locale;
    .locals 2

    .line 130
    invoke-static {}, Lcom/blankj/utilcode/util/UtilsBridge;->getSpUtils4Utils()Lcom/blankj/utilcode/util/SPUtils;

    move-result-object v0

    const-string v1, "KEY_LOCALE"

    invoke-virtual {v0, v1}, Lcom/blankj/utilcode/util/SPUtils;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 131
    .local v0, "spLocaleStr":Ljava/lang/String;
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_1

    const-string v1, "VALUE_FOLLOW_SYSTEM"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    goto :goto_0

    .line 134
    :cond_0
    invoke-static {v0}, Lcom/blankj/utilcode/util/LanguageUtils;->string2Locale(Ljava/lang/String;)Ljava/util/Locale;

    move-result-object v1

    return-object v1

    .line 132
    :cond_1
    :goto_0
    const/4 v1, 0x0

    return-object v1
.end method

.method public static getContextLanguage(Landroid/content/Context;)Ljava/util/Locale;
    .locals 1
    .param p0, "context"    # Landroid/content/Context;

    .line 143
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    invoke-static {v0}, Lcom/blankj/utilcode/util/LanguageUtils;->getLocal(Landroid/content/res/Configuration;)Ljava/util/Locale;

    move-result-object v0

    return-object v0
.end method

.method private static getLocal(Landroid/content/res/Configuration;)Ljava/util/Locale;
    .locals 2
    .param p0, "configuration"    # Landroid/content/res/Configuration;

    .line 304
    nop

    .line 305
    invoke-virtual {p0}, Landroid/content/res/Configuration;->getLocales()Landroid/os/LocaleList;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/os/LocaleList;->get(I)Ljava/util/Locale;

    move-result-object v0

    return-object v0
.end method

.method public static getSystemLanguage()Ljava/util/Locale;
    .locals 1

    .line 161
    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    invoke-static {v0}, Lcom/blankj/utilcode/util/LanguageUtils;->getLocal(Landroid/content/res/Configuration;)Ljava/util/Locale;

    move-result-object v0

    return-object v0
.end method

.method public static isAppliedLanguage()Z
    .locals 1

    .line 107
    invoke-static {}, Lcom/blankj/utilcode/util/LanguageUtils;->getAppliedLanguage()Ljava/util/Locale;

    move-result-object v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public static isAppliedLanguage(Ljava/util/Locale;)Z
    .locals 2
    .param p0, "locale"    # Ljava/util/Locale;

    .line 117
    invoke-static {}, Lcom/blankj/utilcode/util/LanguageUtils;->getAppliedLanguage()Ljava/util/Locale;

    move-result-object v0

    .line 118
    .local v0, "appliedLocale":Ljava/util/Locale;
    if-nez v0, :cond_0

    .line 119
    const/4 v1, 0x0

    return v1

    .line 121
    :cond_0
    invoke-static {p0, v0}, Lcom/blankj/utilcode/util/LanguageUtils;->isSameLocale(Ljava/util/Locale;Ljava/util/Locale;)Z

    move-result v1

    return v1
.end method

.method private static isRightFormatLocalStr(Ljava/lang/String;)Z
    .locals 8
    .param p0, "localStr"    # Ljava/lang/String;

    .line 285
    invoke-virtual {p0}, Ljava/lang/String;->toCharArray()[C

    move-result-object v0

    .line 286
    .local v0, "chars":[C
    const/4 v1, 0x0

    .line 287
    .local v1, "count":I
    array-length v2, v0

    const/4 v3, 0x0

    move v4, v3

    :goto_0
    const/4 v5, 0x1

    if-ge v4, v2, :cond_2

    aget-char v6, v0, v4

    .line 288
    .local v6, "c":C
    const/16 v7, 0x24

    if-ne v6, v7, :cond_1

    .line 289
    if-lt v1, v5, :cond_0

    .line 290
    return v3

    .line 292
    :cond_0
    add-int/lit8 v1, v1, 0x1

    .line 287
    .end local v6    # "c":C
    :cond_1
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    .line 295
    :cond_2
    if-ne v1, v5, :cond_3

    move v3, v5

    :cond_3
    return v3
.end method

.method private static isSameLocale(Ljava/util/Locale;Ljava/util/Locale;)Z
    .locals 2
    .param p0, "l0"    # Ljava/util/Locale;
    .param p1, "l1"    # Ljava/util/Locale;

    .line 299
    invoke-virtual {p1}, Ljava/util/Locale;->getLanguage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0}, Ljava/util/Locale;->getLanguage()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/blankj/utilcode/util/UtilsBridge;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 300
    invoke-virtual {p1}, Ljava/util/Locale;->getCountry()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0}, Ljava/util/Locale;->getCountry()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/blankj/utilcode/util/UtilsBridge;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    .line 299
    :goto_0
    return v0
.end method

.method private static locale2String(Ljava/util/Locale;)Ljava/lang/String;
    .locals 4
    .param p0, "locale"    # Ljava/util/Locale;

    .line 257
    invoke-virtual {p0}, Ljava/util/Locale;->getLanguage()Ljava/lang/String;

    move-result-object v0

    .line 258
    .local v0, "localLanguage":Ljava/lang/String;
    invoke-virtual {p0}, Ljava/util/Locale;->getCountry()Ljava/lang/String;

    move-result-object v1

    .line 259
    .local v1, "localCountry":Ljava/lang/String;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "$"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    return-object v2
.end method

.method static pollCheckAppContextLocal(Ljava/util/Locale;ILcom/blankj/utilcode/util/Utils$Consumer;)V
    .locals 6
    .param p0, "destLocale"    # Ljava/util/Locale;
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Locale;",
            "I",
            "Lcom/blankj/utilcode/util/Utils$Consumer<",
            "Ljava/lang/Boolean;",
            ">;)V"
        }
    .end annotation

    .line 175
    .local p2, "consumer":Lcom/blankj/utilcode/util/Utils$Consumer;, "Lcom/blankj/utilcode/util/Utils$Consumer<Ljava/lang/Boolean;>;"
    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/Application;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    .line 176
    .local v0, "appResources":Landroid/content/res/Resources;
    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v1

    .line 177
    .local v1, "appConfig":Landroid/content/res/Configuration;
    invoke-static {v1}, Lcom/blankj/utilcode/util/LanguageUtils;->getLocal(Landroid/content/res/Configuration;)Ljava/util/Locale;

    move-result-object v2

    .line 179
    .local v2, "appLocal":Ljava/util/Locale;
    invoke-static {v1, p0}, Lcom/blankj/utilcode/util/LanguageUtils;->setLocal(Landroid/content/res/Configuration;Ljava/util/Locale;)V

    .line 181
    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v3

    invoke-virtual {v3}, Landroid/app/Application;->getResources()Landroid/content/res/Resources;

    move-result-object v3

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v4

    invoke-virtual {v3, v1, v4}, Landroid/content/res/Resources;->updateConfiguration(Landroid/content/res/Configuration;Landroid/util/DisplayMetrics;)V

    .line 183
    if-nez p2, :cond_0

    return-void

    .line 185
    :cond_0
    invoke-static {v2, p0}, Lcom/blankj/utilcode/util/LanguageUtils;->isSameLocale(Ljava/util/Locale;Ljava/util/Locale;)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 186
    const/4 v3, 0x1

    invoke-static {v3}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    invoke-interface {p2, v3}, Lcom/blankj/utilcode/util/Utils$Consumer;->accept(Ljava/lang/Object;)V

    goto :goto_0

    .line 188
    :cond_1
    const/16 v3, 0x14

    if-ge p1, v3, :cond_2

    .line 189
    new-instance v3, Lcom/blankj/utilcode/util/LanguageUtils$2;

    invoke-direct {v3, p0, p1, p2}, Lcom/blankj/utilcode/util/LanguageUtils$2;-><init>(Ljava/util/Locale;ILcom/blankj/utilcode/util/Utils$Consumer;)V

    const-wide/16 v4, 0x10

    invoke-static {v3, v4, v5}, Lcom/blankj/utilcode/util/UtilsBridge;->runOnUiThreadDelayed(Ljava/lang/Runnable;J)V

    .line 195
    return-void

    .line 197
    :cond_2
    const-string v3, "LanguageUtils"

    const-string v4, "appLocal didn\'t update."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 198
    const/4 v3, 0x0

    invoke-static {v3}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    invoke-interface {p2, v3}, Lcom/blankj/utilcode/util/Utils$Consumer;->accept(Ljava/lang/Object;)V

    .line 200
    :goto_0
    return-void
.end method

.method private static restart(Z)V
    .locals 2
    .param p0, "isRelaunchApp"    # Z

    .line 92
    if-eqz p0, :cond_0

    .line 93
    invoke-static {}, Lcom/blankj/utilcode/util/UtilsBridge;->relaunchApp()V

    goto :goto_1

    .line 95
    :cond_0
    invoke-static {}, Lcom/blankj/utilcode/util/UtilsBridge;->getActivityList()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/app/Activity;

    .line 96
    .local v1, "activity":Landroid/app/Activity;
    invoke-virtual {v1}, Landroid/app/Activity;->recreate()V

    .line 97
    .end local v1    # "activity":Landroid/app/Activity;
    goto :goto_0

    .line 99
    :cond_1
    :goto_1
    return-void
.end method

.method private static setLocal(Landroid/content/res/Configuration;Ljava/util/Locale;)V
    .locals 0
    .param p0, "configuration"    # Landroid/content/res/Configuration;
    .param p1, "locale"    # Ljava/util/Locale;

    .line 312
    nop

    .line 313
    invoke-virtual {p0, p1}, Landroid/content/res/Configuration;->setLocale(Ljava/util/Locale;)V

    .line 317
    return-void
.end method

.method private static string2Locale(Ljava/lang/String;)Ljava/util/Locale;
    .locals 3
    .param p0, "str"    # Ljava/lang/String;

    .line 263
    invoke-static {p0}, Lcom/blankj/utilcode/util/LanguageUtils;->string2LocaleReal(Ljava/lang/String;)Ljava/util/Locale;

    move-result-object v0

    .line 264
    .local v0, "locale":Ljava/util/Locale;
    if-nez v0, :cond_0

    .line 265
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "The string of "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " is not in the correct format."

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v2, "LanguageUtils"

    invoke-static {v2, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 266
    invoke-static {}, Lcom/blankj/utilcode/util/UtilsBridge;->getSpUtils4Utils()Lcom/blankj/utilcode/util/SPUtils;

    move-result-object v1

    const-string v2, "KEY_LOCALE"

    invoke-virtual {v1, v2}, Lcom/blankj/utilcode/util/SPUtils;->remove(Ljava/lang/String;)V

    .line 268
    :cond_0
    return-object v0
.end method

.method private static string2LocaleReal(Ljava/lang/String;)Ljava/util/Locale;
    .locals 5
    .param p0, "str"    # Ljava/lang/String;

    .line 272
    invoke-static {p0}, Lcom/blankj/utilcode/util/LanguageUtils;->isRightFormatLocalStr(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    .line 273
    return-object v1

    .line 277
    :cond_0
    :try_start_0
    const-string v0, "$"

    invoke-virtual {p0, v0}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v0

    .line 278
    .local v0, "splitIndex":I
    new-instance v2, Ljava/util/Locale;

    const/4 v3, 0x0

    invoke-virtual {p0, v3, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    add-int/lit8 v4, v0, 0x1

    invoke-virtual {p0, v4}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v4

    invoke-direct {v2, v3, v4}, Ljava/util/Locale;-><init>(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v2

    .line 279
    .end local v0    # "splitIndex":I
    :catch_0
    move-exception v0

    .line 280
    .local v0, "ignore":Ljava/lang/Exception;
    return-object v1
.end method

.method public static updateAppContextLanguage(Ljava/util/Locale;Lcom/blankj/utilcode/util/Utils$Consumer;)V
    .locals 1
    .param p0, "destLocale"    # Ljava/util/Locale;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Locale;",
            "Lcom/blankj/utilcode/util/Utils$Consumer<",
            "Ljava/lang/Boolean;",
            ">;)V"
        }
    .end annotation

    .line 171
    .local p1, "consumer":Lcom/blankj/utilcode/util/Utils$Consumer;, "Lcom/blankj/utilcode/util/Utils$Consumer<Ljava/lang/Boolean;>;"
    const/4 v0, 0x0

    invoke-static {p0, v0, p1}, Lcom/blankj/utilcode/util/LanguageUtils;->pollCheckAppContextLocal(Ljava/util/Locale;ILcom/blankj/utilcode/util/Utils$Consumer;)V

    .line 172
    return-void
.end method

.method private static updateConfiguration(Landroid/content/Context;Ljava/util/Locale;)V
    .locals 3
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "destLocal"    # Ljava/util/Locale;

    .line 250
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    .line 251
    .local v0, "resources":Landroid/content/res/Resources;
    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v1

    .line 252
    .local v1, "config":Landroid/content/res/Configuration;
    invoke-static {v1, p1}, Lcom/blankj/utilcode/util/LanguageUtils;->setLocal(Landroid/content/res/Configuration;Ljava/util/Locale;)V

    .line 253
    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/res/Resources;->updateConfiguration(Landroid/content/res/Configuration;Landroid/util/DisplayMetrics;)V

    .line 254
    return-void
.end method
