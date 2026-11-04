.class public Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;
.super Ljava/lang/Object;
.source "DatatypeFeatures.java"

# interfaces
.implements Ljava/io/Serializable;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures$DefaultHolder;
    }
.end annotation


# static fields
.field protected static final FEATURE_INDEX_ENUM:I = 0x0

.field protected static final FEATURE_INDEX_JSON_NODE:I = 0x1

.field private static final serialVersionUID:J = 0x1L


# instance fields
.field private final _enabledFor1:I

.field private final _enabledFor2:I

.field private final _explicitFor1:I

.field private final _explicitFor2:I


# direct methods
.method protected constructor <init>(IIII)V
    .locals 0
    .param p1, "enabledFor1"    # I
    .param p2, "explicitFor1"    # I
    .param p3, "enabledFor2"    # I
    .param p4, "explicitFor2"    # I

    .line 25
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 26
    iput p1, p0, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_enabledFor1:I

    .line 27
    iput p2, p0, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_explicitFor1:I

    .line 28
    iput p3, p0, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_enabledFor2:I

    .line 29
    iput p4, p0, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_explicitFor2:I

    .line 30
    return-void
.end method

.method private static final varargs _calcMask([Lcom/fasterxml/jackson/databind/cfg/DatatypeFeature;)I
    .locals 5
    .param p0, "features"    # [Lcom/fasterxml/jackson/databind/cfg/DatatypeFeature;

    .line 155
    const/4 v0, 0x0

    .line 156
    .local v0, "mask":I
    array-length v1, p0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_0

    aget-object v3, p0, v2

    .line 157
    .local v3, "f":Lcom/fasterxml/jackson/databind/cfg/DatatypeFeature;
    invoke-interface {v3}, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeature;->getMask()I

    move-result v4

    or-int/2addr v0, v4

    .line 156
    .end local v3    # "f":Lcom/fasterxml/jackson/databind/cfg/DatatypeFeature;
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 159
    :cond_0
    return v0
.end method

.method private _with(IIII)Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;
    .locals 1
    .param p1, "enabledFor1"    # I
    .param p2, "explicitFor1"    # I
    .param p3, "enabledFor2"    # I
    .param p4, "explicitFor2"    # I

    .line 38
    iget v0, p0, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_enabledFor1:I

    if-ne v0, p1, :cond_0

    iget v0, p0, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_explicitFor1:I

    if-ne v0, p2, :cond_0

    iget v0, p0, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_enabledFor2:I

    if-ne v0, p3, :cond_0

    iget v0, p0, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_explicitFor2:I

    if-ne v0, p4, :cond_0

    .line 40
    return-object p0

    .line 42
    :cond_0
    new-instance v0, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;

    invoke-direct {v0, p1, p2, p3, p4}, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;-><init>(IIII)V

    return-object v0
.end method

.method public static defaultFeatures()Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;
    .locals 1

    .line 33
    invoke-static {}, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures$DefaultHolder;->getDefault()Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method public getExplicitState(Lcom/fasterxml/jackson/databind/cfg/DatatypeFeature;)Ljava/lang/Boolean;
    .locals 2
    .param p1, "f"    # Lcom/fasterxml/jackson/databind/cfg/DatatypeFeature;

    .line 222
    invoke-interface {p1}, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeature;->featureIndex()I

    move-result v0

    const/4 v1, 0x0

    packed-switch v0, :pswitch_data_0

    .line 234
    invoke-static {}, Lcom/fasterxml/jackson/core/util/VersionUtil;->throwInternal()V

    .line 235
    return-object v1

    .line 229
    :pswitch_0
    iget v0, p0, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_explicitFor2:I

    invoke-interface {p1, v0}, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeature;->enabledIn(I)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 230
    iget v0, p0, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_enabledFor2:I

    invoke-interface {p1, v0}, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeature;->enabledIn(I)Z

    move-result v0

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    return-object v0

    .line 232
    :cond_0
    return-object v1

    .line 224
    :pswitch_1
    iget v0, p0, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_explicitFor1:I

    invoke-interface {p1, v0}, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeature;->enabledIn(I)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 225
    iget v0, p0, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_enabledFor1:I

    invoke-interface {p1, v0}, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeature;->enabledIn(I)Z

    move-result v0

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    return-object v0

    .line 227
    :cond_1
    return-object v1

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public isEnabled(Lcom/fasterxml/jackson/databind/cfg/DatatypeFeature;)Z
    .locals 1
    .param p1, "f"    # Lcom/fasterxml/jackson/databind/cfg/DatatypeFeature;

    .line 179
    invoke-interface {p1}, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeature;->featureIndex()I

    move-result v0

    packed-switch v0, :pswitch_data_0

    .line 185
    invoke-static {}, Lcom/fasterxml/jackson/core/util/VersionUtil;->throwInternal()V

    .line 186
    const/4 v0, 0x0

    return v0

    .line 183
    :pswitch_0
    iget v0, p0, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_enabledFor2:I

    invoke-interface {p1, v0}, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeature;->enabledIn(I)Z

    move-result v0

    return v0

    .line 181
    :pswitch_1
    iget v0, p0, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_enabledFor1:I

    invoke-interface {p1, v0}, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeature;->enabledIn(I)Z

    move-result v0

    return v0

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public isExplicitlySet(Lcom/fasterxml/jackson/databind/cfg/DatatypeFeature;)Z
    .locals 1
    .param p1, "f"    # Lcom/fasterxml/jackson/databind/cfg/DatatypeFeature;

    .line 200
    invoke-interface {p1}, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeature;->featureIndex()I

    move-result v0

    packed-switch v0, :pswitch_data_0

    .line 206
    invoke-static {}, Lcom/fasterxml/jackson/core/util/VersionUtil;->throwInternal()V

    .line 207
    const/4 v0, 0x0

    return v0

    .line 204
    :pswitch_0
    iget v0, p0, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_explicitFor2:I

    invoke-interface {p1, v0}, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeature;->enabledIn(I)Z

    move-result v0

    return v0

    .line 202
    :pswitch_1
    iget v0, p0, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_explicitFor1:I

    invoke-interface {p1, v0}, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeature;->enabledIn(I)Z

    move-result v0

    return v0

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public with(Lcom/fasterxml/jackson/databind/cfg/DatatypeFeature;)Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;
    .locals 5
    .param p1, "f"    # Lcom/fasterxml/jackson/databind/cfg/DatatypeFeature;

    .line 62
    invoke-interface {p1}, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeature;->getMask()I

    move-result v0

    .line 63
    .local v0, "mask":I
    invoke-interface {p1}, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeature;->featureIndex()I

    move-result v1

    packed-switch v1, :pswitch_data_0

    .line 71
    invoke-static {}, Lcom/fasterxml/jackson/core/util/VersionUtil;->throwInternal()V

    .line 72
    return-object p0

    .line 68
    :pswitch_0
    iget v1, p0, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_enabledFor1:I

    iget v2, p0, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_explicitFor1:I

    iget v3, p0, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_enabledFor2:I

    or-int/2addr v3, v0

    iget v4, p0, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_explicitFor2:I

    or-int/2addr v4, v0

    invoke-direct {p0, v1, v2, v3, v4}, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_with(IIII)Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;

    move-result-object v1

    return-object v1

    .line 65
    :pswitch_1
    iget v1, p0, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_enabledFor1:I

    or-int/2addr v1, v0

    iget v2, p0, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_explicitFor1:I

    or-int/2addr v2, v0

    iget v3, p0, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_enabledFor2:I

    iget v4, p0, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_explicitFor2:I

    invoke-direct {p0, v1, v2, v3, v4}, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_with(IIII)Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;

    move-result-object v1

    return-object v1

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public varargs withFeatures([Lcom/fasterxml/jackson/databind/cfg/DatatypeFeature;)Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;
    .locals 5
    .param p1, "features"    # [Lcom/fasterxml/jackson/databind/cfg/DatatypeFeature;

    .line 86
    invoke-static {p1}, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_calcMask([Lcom/fasterxml/jackson/databind/cfg/DatatypeFeature;)I

    move-result v0

    .line 87
    .local v0, "mask":I
    if-nez v0, :cond_0

    .line 88
    return-object p0

    .line 90
    :cond_0
    const/4 v1, 0x0

    aget-object v1, p1, v1

    invoke-interface {v1}, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeature;->featureIndex()I

    move-result v1

    packed-switch v1, :pswitch_data_0

    .line 98
    invoke-static {}, Lcom/fasterxml/jackson/core/util/VersionUtil;->throwInternal()V

    .line 99
    return-object p0

    .line 95
    :pswitch_0
    iget v1, p0, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_enabledFor1:I

    iget v2, p0, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_explicitFor1:I

    iget v3, p0, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_enabledFor2:I

    or-int/2addr v3, v0

    iget v4, p0, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_explicitFor2:I

    or-int/2addr v4, v0

    invoke-direct {p0, v1, v2, v3, v4}, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_with(IIII)Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;

    move-result-object v1

    return-object v1

    .line 92
    :pswitch_1
    iget v1, p0, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_enabledFor1:I

    or-int/2addr v1, v0

    iget v2, p0, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_explicitFor1:I

    or-int/2addr v2, v0

    iget v3, p0, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_enabledFor2:I

    iget v4, p0, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_explicitFor2:I

    invoke-direct {p0, v1, v2, v3, v4}, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_with(IIII)Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;

    move-result-object v1

    return-object v1

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public without(Lcom/fasterxml/jackson/databind/cfg/DatatypeFeature;)Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;
    .locals 5
    .param p1, "f"    # Lcom/fasterxml/jackson/databind/cfg/DatatypeFeature;

    .line 113
    invoke-interface {p1}, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeature;->getMask()I

    move-result v0

    .line 114
    .local v0, "mask":I
    invoke-interface {p1}, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeature;->featureIndex()I

    move-result v1

    packed-switch v1, :pswitch_data_0

    .line 122
    invoke-static {}, Lcom/fasterxml/jackson/core/util/VersionUtil;->throwInternal()V

    .line 123
    return-object p0

    .line 119
    :pswitch_0
    iget v1, p0, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_enabledFor1:I

    iget v2, p0, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_explicitFor1:I

    iget v3, p0, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_enabledFor2:I

    not-int v4, v0

    and-int/2addr v3, v4

    iget v4, p0, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_explicitFor2:I

    or-int/2addr v4, v0

    invoke-direct {p0, v1, v2, v3, v4}, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_with(IIII)Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;

    move-result-object v1

    return-object v1

    .line 116
    :pswitch_1
    iget v1, p0, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_enabledFor1:I

    not-int v2, v0

    and-int/2addr v1, v2

    iget v2, p0, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_explicitFor1:I

    or-int/2addr v2, v0

    iget v3, p0, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_enabledFor2:I

    iget v4, p0, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_explicitFor2:I

    invoke-direct {p0, v1, v2, v3, v4}, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_with(IIII)Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;

    move-result-object v1

    return-object v1

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public varargs withoutFeatures([Lcom/fasterxml/jackson/databind/cfg/DatatypeFeature;)Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;
    .locals 5
    .param p1, "features"    # [Lcom/fasterxml/jackson/databind/cfg/DatatypeFeature;

    .line 137
    invoke-static {p1}, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_calcMask([Lcom/fasterxml/jackson/databind/cfg/DatatypeFeature;)I

    move-result v0

    .line 138
    .local v0, "mask":I
    if-nez v0, :cond_0

    .line 139
    return-object p0

    .line 141
    :cond_0
    const/4 v1, 0x0

    aget-object v1, p1, v1

    invoke-interface {v1}, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeature;->featureIndex()I

    move-result v1

    packed-switch v1, :pswitch_data_0

    .line 149
    invoke-static {}, Lcom/fasterxml/jackson/core/util/VersionUtil;->throwInternal()V

    .line 150
    return-object p0

    .line 146
    :pswitch_0
    iget v1, p0, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_enabledFor1:I

    iget v2, p0, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_explicitFor1:I

    iget v3, p0, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_enabledFor2:I

    not-int v4, v0

    and-int/2addr v3, v4

    iget v4, p0, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_explicitFor2:I

    or-int/2addr v4, v0

    invoke-direct {p0, v1, v2, v3, v4}, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_with(IIII)Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;

    move-result-object v1

    return-object v1

    .line 143
    :pswitch_1
    iget v1, p0, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_enabledFor1:I

    not-int v2, v0

    and-int/2addr v1, v2

    iget v2, p0, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_explicitFor1:I

    or-int/2addr v2, v0

    iget v3, p0, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_enabledFor2:I

    iget v4, p0, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_explicitFor2:I

    invoke-direct {p0, v1, v2, v3, v4}, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;->_with(IIII)Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;

    move-result-object v1

    return-object v1

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
