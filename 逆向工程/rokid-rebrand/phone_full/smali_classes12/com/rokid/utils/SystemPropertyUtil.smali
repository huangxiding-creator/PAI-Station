.class public Lcom/rokid/utils/SystemPropertyUtil;
.super Ljava/lang/Object;
.source "SystemPropertyUtil.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 8
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static get(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p0, "propertyKey"    # Ljava/lang/String;

    .line 20
    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 21
    const/4 v0, 0x0

    return-object v0

    .line 23
    :cond_0
    invoke-static {p0}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 24
    .local v0, "property":Ljava/lang/String;
    return-object v0
.end method

.method public static getIntProperty(Ljava/lang/String;)I
    .locals 3
    .param p0, "propertyKey"    # Ljava/lang/String;

    .line 30
    invoke-static {p0}, Lcom/rokid/utils/SystemPropertyUtil;->getStringProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 31
    .local v0, "prop":Ljava/lang/String;
    const/4 v1, -0x1

    .line 32
    .local v1, "property":I
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_0

    .line 33
    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v1

    .line 35
    :cond_0
    return v1
.end method

.method public static getStringProperty(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p0, "propertyKey"    # Ljava/lang/String;

    .line 11
    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 12
    const/4 v0, 0x0

    return-object v0

    .line 14
    :cond_0
    invoke-static {p0}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 15
    .local v0, "property":Ljava/lang/String;
    return-object v0
.end method
