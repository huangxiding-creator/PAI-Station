.class public final enum Lcom/fasterxml/jackson/databind/JsonNode$OverwriteMode;
.super Ljava/lang/Enum;
.source "JsonNode.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/fasterxml/jackson/databind/JsonNode;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "OverwriteMode"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/fasterxml/jackson/databind/JsonNode$OverwriteMode;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/fasterxml/jackson/databind/JsonNode$OverwriteMode;

.field public static final enum ALL:Lcom/fasterxml/jackson/databind/JsonNode$OverwriteMode;

.field public static final enum NONE:Lcom/fasterxml/jackson/databind/JsonNode$OverwriteMode;

.field public static final enum NULLS:Lcom/fasterxml/jackson/databind/JsonNode$OverwriteMode;

.field public static final enum SCALARS:Lcom/fasterxml/jackson/databind/JsonNode$OverwriteMode;


# direct methods
.method static constructor <clinit>()V
    .locals 4

    .line 63
    new-instance v0, Lcom/fasterxml/jackson/databind/JsonNode$OverwriteMode;

    const-string v1, "NONE"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/fasterxml/jackson/databind/JsonNode$OverwriteMode;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/fasterxml/jackson/databind/JsonNode$OverwriteMode;->NONE:Lcom/fasterxml/jackson/databind/JsonNode$OverwriteMode;

    .line 69
    new-instance v0, Lcom/fasterxml/jackson/databind/JsonNode$OverwriteMode;

    const-string v1, "NULLS"

    const/4 v2, 0x1

    invoke-direct {v0, v1, v2}, Lcom/fasterxml/jackson/databind/JsonNode$OverwriteMode;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/fasterxml/jackson/databind/JsonNode$OverwriteMode;->NULLS:Lcom/fasterxml/jackson/databind/JsonNode$OverwriteMode;

    .line 75
    new-instance v0, Lcom/fasterxml/jackson/databind/JsonNode$OverwriteMode;

    const-string v1, "SCALARS"

    const/4 v2, 0x2

    invoke-direct {v0, v1, v2}, Lcom/fasterxml/jackson/databind/JsonNode$OverwriteMode;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/fasterxml/jackson/databind/JsonNode$OverwriteMode;->SCALARS:Lcom/fasterxml/jackson/databind/JsonNode$OverwriteMode;

    .line 81
    new-instance v0, Lcom/fasterxml/jackson/databind/JsonNode$OverwriteMode;

    const-string v1, "ALL"

    const/4 v2, 0x3

    invoke-direct {v0, v1, v2}, Lcom/fasterxml/jackson/databind/JsonNode$OverwriteMode;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/fasterxml/jackson/databind/JsonNode$OverwriteMode;->ALL:Lcom/fasterxml/jackson/databind/JsonNode$OverwriteMode;

    .line 58
    sget-object v0, Lcom/fasterxml/jackson/databind/JsonNode$OverwriteMode;->NONE:Lcom/fasterxml/jackson/databind/JsonNode$OverwriteMode;

    sget-object v1, Lcom/fasterxml/jackson/databind/JsonNode$OverwriteMode;->NULLS:Lcom/fasterxml/jackson/databind/JsonNode$OverwriteMode;

    sget-object v2, Lcom/fasterxml/jackson/databind/JsonNode$OverwriteMode;->SCALARS:Lcom/fasterxml/jackson/databind/JsonNode$OverwriteMode;

    sget-object v3, Lcom/fasterxml/jackson/databind/JsonNode$OverwriteMode;->ALL:Lcom/fasterxml/jackson/databind/JsonNode$OverwriteMode;

    filled-new-array {v0, v1, v2, v3}, [Lcom/fasterxml/jackson/databind/JsonNode$OverwriteMode;

    move-result-object v0

    sput-object v0, Lcom/fasterxml/jackson/databind/JsonNode$OverwriteMode;->$VALUES:[Lcom/fasterxml/jackson/databind/JsonNode$OverwriteMode;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 58
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/fasterxml/jackson/databind/JsonNode$OverwriteMode;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .line 58
    const-class v0, Lcom/fasterxml/jackson/databind/JsonNode$OverwriteMode;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/fasterxml/jackson/databind/JsonNode$OverwriteMode;

    return-object v0
.end method

.method public static values()[Lcom/fasterxml/jackson/databind/JsonNode$OverwriteMode;
    .locals 1

    .line 58
    sget-object v0, Lcom/fasterxml/jackson/databind/JsonNode$OverwriteMode;->$VALUES:[Lcom/fasterxml/jackson/databind/JsonNode$OverwriteMode;

    invoke-virtual {v0}, [Lcom/fasterxml/jackson/databind/JsonNode$OverwriteMode;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/fasterxml/jackson/databind/JsonNode$OverwriteMode;

    return-object v0
.end method
