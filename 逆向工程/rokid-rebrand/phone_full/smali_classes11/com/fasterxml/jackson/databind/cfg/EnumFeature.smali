.class public final enum Lcom/fasterxml/jackson/databind/cfg/EnumFeature;
.super Ljava/lang/Enum;
.source "EnumFeature.java"

# interfaces
.implements Lcom/fasterxml/jackson/databind/cfg/DatatypeFeature;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/fasterxml/jackson/databind/cfg/EnumFeature;",
        ">;",
        "Lcom/fasterxml/jackson/databind/cfg/DatatypeFeature;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/fasterxml/jackson/databind/cfg/EnumFeature;

.field public static final enum BOGUS_FEATURE:Lcom/fasterxml/jackson/databind/cfg/EnumFeature;

.field private static final FEATURE_INDEX:I


# instance fields
.field private final _enabledByDefault:Z

.field private final _mask:I


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .line 11
    new-instance v0, Lcom/fasterxml/jackson/databind/cfg/EnumFeature;

    const-string v1, "BOGUS_FEATURE"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2, v2}, Lcom/fasterxml/jackson/databind/cfg/EnumFeature;-><init>(Ljava/lang/String;IZ)V

    sput-object v0, Lcom/fasterxml/jackson/databind/cfg/EnumFeature;->BOGUS_FEATURE:Lcom/fasterxml/jackson/databind/cfg/EnumFeature;

    .line 9
    sget-object v0, Lcom/fasterxml/jackson/databind/cfg/EnumFeature;->BOGUS_FEATURE:Lcom/fasterxml/jackson/databind/cfg/EnumFeature;

    filled-new-array {v0}, [Lcom/fasterxml/jackson/databind/cfg/EnumFeature;

    move-result-object v0

    sput-object v0, Lcom/fasterxml/jackson/databind/cfg/EnumFeature;->$VALUES:[Lcom/fasterxml/jackson/databind/cfg/EnumFeature;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;IZ)V
    .locals 0
    .param p3, "enabledByDefault"    # Z
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(Z)V"
        }
    .end annotation

    .line 22
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    .line 23
    iput-boolean p3, p0, Lcom/fasterxml/jackson/databind/cfg/EnumFeature;->_enabledByDefault:Z

    .line 24
    const/4 p1, 0x1

    invoke-virtual {p0}, Lcom/fasterxml/jackson/databind/cfg/EnumFeature;->ordinal()I

    move-result p2

    shl-int/2addr p1, p2

    iput p1, p0, Lcom/fasterxml/jackson/databind/cfg/EnumFeature;->_mask:I

    .line 25
    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/fasterxml/jackson/databind/cfg/EnumFeature;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .line 9
    const-class v0, Lcom/fasterxml/jackson/databind/cfg/EnumFeature;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/fasterxml/jackson/databind/cfg/EnumFeature;

    return-object v0
.end method

.method public static values()[Lcom/fasterxml/jackson/databind/cfg/EnumFeature;
    .locals 1

    .line 9
    sget-object v0, Lcom/fasterxml/jackson/databind/cfg/EnumFeature;->$VALUES:[Lcom/fasterxml/jackson/databind/cfg/EnumFeature;

    invoke-virtual {v0}, [Lcom/fasterxml/jackson/databind/cfg/EnumFeature;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/fasterxml/jackson/databind/cfg/EnumFeature;

    return-object v0
.end method


# virtual methods
.method public enabledByDefault()Z
    .locals 1

    .line 28
    iget-boolean v0, p0, Lcom/fasterxml/jackson/databind/cfg/EnumFeature;->_enabledByDefault:Z

    return v0
.end method

.method public enabledIn(I)Z
    .locals 1
    .param p1, "flags"    # I

    .line 30
    iget v0, p0, Lcom/fasterxml/jackson/databind/cfg/EnumFeature;->_mask:I

    and-int/2addr v0, p1

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public featureIndex()I
    .locals 1

    .line 36
    const/4 v0, 0x0

    return v0
.end method

.method public getMask()I
    .locals 1

    .line 32
    iget v0, p0, Lcom/fasterxml/jackson/databind/cfg/EnumFeature;->_mask:I

    return v0
.end method
