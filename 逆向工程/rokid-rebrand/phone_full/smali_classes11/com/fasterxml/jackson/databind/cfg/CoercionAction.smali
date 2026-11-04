.class public final enum Lcom/fasterxml/jackson/databind/cfg/CoercionAction;
.super Ljava/lang/Enum;
.source "CoercionAction.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/fasterxml/jackson/databind/cfg/CoercionAction;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/fasterxml/jackson/databind/cfg/CoercionAction;

.field public static final enum AsEmpty:Lcom/fasterxml/jackson/databind/cfg/CoercionAction;

.field public static final enum AsNull:Lcom/fasterxml/jackson/databind/cfg/CoercionAction;

.field public static final enum Fail:Lcom/fasterxml/jackson/databind/cfg/CoercionAction;

.field public static final enum TryConvert:Lcom/fasterxml/jackson/databind/cfg/CoercionAction;


# direct methods
.method static constructor <clinit>()V
    .locals 4

    .line 21
    new-instance v0, Lcom/fasterxml/jackson/databind/cfg/CoercionAction;

    const-string v1, "Fail"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/fasterxml/jackson/databind/cfg/CoercionAction;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/fasterxml/jackson/databind/cfg/CoercionAction;->Fail:Lcom/fasterxml/jackson/databind/cfg/CoercionAction;

    .line 26
    new-instance v0, Lcom/fasterxml/jackson/databind/cfg/CoercionAction;

    const-string v1, "TryConvert"

    const/4 v2, 0x1

    invoke-direct {v0, v1, v2}, Lcom/fasterxml/jackson/databind/cfg/CoercionAction;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/fasterxml/jackson/databind/cfg/CoercionAction;->TryConvert:Lcom/fasterxml/jackson/databind/cfg/CoercionAction;

    .line 31
    new-instance v0, Lcom/fasterxml/jackson/databind/cfg/CoercionAction;

    const-string v1, "AsNull"

    const/4 v2, 0x2

    invoke-direct {v0, v1, v2}, Lcom/fasterxml/jackson/databind/cfg/CoercionAction;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/fasterxml/jackson/databind/cfg/CoercionAction;->AsNull:Lcom/fasterxml/jackson/databind/cfg/CoercionAction;

    .line 40
    new-instance v0, Lcom/fasterxml/jackson/databind/cfg/CoercionAction;

    const-string v1, "AsEmpty"

    const/4 v2, 0x3

    invoke-direct {v0, v1, v2}, Lcom/fasterxml/jackson/databind/cfg/CoercionAction;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/fasterxml/jackson/databind/cfg/CoercionAction;->AsEmpty:Lcom/fasterxml/jackson/databind/cfg/CoercionAction;

    .line 16
    sget-object v0, Lcom/fasterxml/jackson/databind/cfg/CoercionAction;->Fail:Lcom/fasterxml/jackson/databind/cfg/CoercionAction;

    sget-object v1, Lcom/fasterxml/jackson/databind/cfg/CoercionAction;->TryConvert:Lcom/fasterxml/jackson/databind/cfg/CoercionAction;

    sget-object v2, Lcom/fasterxml/jackson/databind/cfg/CoercionAction;->AsNull:Lcom/fasterxml/jackson/databind/cfg/CoercionAction;

    sget-object v3, Lcom/fasterxml/jackson/databind/cfg/CoercionAction;->AsEmpty:Lcom/fasterxml/jackson/databind/cfg/CoercionAction;

    filled-new-array {v0, v1, v2, v3}, [Lcom/fasterxml/jackson/databind/cfg/CoercionAction;

    move-result-object v0

    sput-object v0, Lcom/fasterxml/jackson/databind/cfg/CoercionAction;->$VALUES:[Lcom/fasterxml/jackson/databind/cfg/CoercionAction;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 16
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/fasterxml/jackson/databind/cfg/CoercionAction;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .line 16
    const-class v0, Lcom/fasterxml/jackson/databind/cfg/CoercionAction;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/fasterxml/jackson/databind/cfg/CoercionAction;

    return-object v0
.end method

.method public static values()[Lcom/fasterxml/jackson/databind/cfg/CoercionAction;
    .locals 1

    .line 16
    sget-object v0, Lcom/fasterxml/jackson/databind/cfg/CoercionAction;->$VALUES:[Lcom/fasterxml/jackson/databind/cfg/CoercionAction;

    invoke-virtual {v0}, [Lcom/fasterxml/jackson/databind/cfg/CoercionAction;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/fasterxml/jackson/databind/cfg/CoercionAction;

    return-object v0
.end method
