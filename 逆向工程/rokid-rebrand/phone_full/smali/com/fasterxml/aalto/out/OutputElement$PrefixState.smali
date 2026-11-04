.class public final enum Lcom/fasterxml/aalto/out/OutputElement$PrefixState;
.super Ljava/lang/Enum;
.source "OutputElement.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/fasterxml/aalto/out/OutputElement;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "PrefixState"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/fasterxml/aalto/out/OutputElement$PrefixState;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/fasterxml/aalto/out/OutputElement$PrefixState;

.field public static final enum MISBOUND:Lcom/fasterxml/aalto/out/OutputElement$PrefixState;

.field public static final enum OK:Lcom/fasterxml/aalto/out/OutputElement$PrefixState;

.field public static final enum UNBOUND:Lcom/fasterxml/aalto/out/OutputElement$PrefixState;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .line 41
    new-instance v0, Lcom/fasterxml/aalto/out/OutputElement$PrefixState;

    const-string v1, "UNBOUND"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/fasterxml/aalto/out/OutputElement$PrefixState;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/fasterxml/aalto/out/OutputElement$PrefixState;->UNBOUND:Lcom/fasterxml/aalto/out/OutputElement$PrefixState;

    new-instance v0, Lcom/fasterxml/aalto/out/OutputElement$PrefixState;

    const-string v1, "OK"

    const/4 v2, 0x1

    invoke-direct {v0, v1, v2}, Lcom/fasterxml/aalto/out/OutputElement$PrefixState;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/fasterxml/aalto/out/OutputElement$PrefixState;->OK:Lcom/fasterxml/aalto/out/OutputElement$PrefixState;

    new-instance v0, Lcom/fasterxml/aalto/out/OutputElement$PrefixState;

    const-string v1, "MISBOUND"

    const/4 v2, 0x2

    invoke-direct {v0, v1, v2}, Lcom/fasterxml/aalto/out/OutputElement$PrefixState;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/fasterxml/aalto/out/OutputElement$PrefixState;->MISBOUND:Lcom/fasterxml/aalto/out/OutputElement$PrefixState;

    .line 40
    sget-object v0, Lcom/fasterxml/aalto/out/OutputElement$PrefixState;->UNBOUND:Lcom/fasterxml/aalto/out/OutputElement$PrefixState;

    sget-object v1, Lcom/fasterxml/aalto/out/OutputElement$PrefixState;->OK:Lcom/fasterxml/aalto/out/OutputElement$PrefixState;

    sget-object v2, Lcom/fasterxml/aalto/out/OutputElement$PrefixState;->MISBOUND:Lcom/fasterxml/aalto/out/OutputElement$PrefixState;

    filled-new-array {v0, v1, v2}, [Lcom/fasterxml/aalto/out/OutputElement$PrefixState;

    move-result-object v0

    sput-object v0, Lcom/fasterxml/aalto/out/OutputElement$PrefixState;->$VALUES:[Lcom/fasterxml/aalto/out/OutputElement$PrefixState;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 40
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/fasterxml/aalto/out/OutputElement$PrefixState;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .line 40
    const-class v0, Lcom/fasterxml/aalto/out/OutputElement$PrefixState;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/fasterxml/aalto/out/OutputElement$PrefixState;

    return-object v0
.end method

.method public static values()[Lcom/fasterxml/aalto/out/OutputElement$PrefixState;
    .locals 1

    .line 40
    sget-object v0, Lcom/fasterxml/aalto/out/OutputElement$PrefixState;->$VALUES:[Lcom/fasterxml/aalto/out/OutputElement$PrefixState;

    invoke-virtual {v0}, [Lcom/fasterxml/aalto/out/OutputElement$PrefixState;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/fasterxml/aalto/out/OutputElement$PrefixState;

    return-object v0
.end method
