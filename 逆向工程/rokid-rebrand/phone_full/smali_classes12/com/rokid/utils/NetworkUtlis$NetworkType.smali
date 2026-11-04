.class public final enum Lcom/rokid/utils/NetworkUtlis$NetworkType;
.super Ljava/lang/Enum;
.source "NetworkUtlis.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/utils/NetworkUtlis;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "NetworkType"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/rokid/utils/NetworkUtlis$NetworkType;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/rokid/utils/NetworkUtlis$NetworkType;

.field public static final enum NETWORK_ETHERNET:Lcom/rokid/utils/NetworkUtlis$NetworkType;

.field public static final enum NETWORK_MOBILE:Lcom/rokid/utils/NetworkUtlis$NetworkType;

.field public static final enum NETWORK_NONE:Lcom/rokid/utils/NetworkUtlis$NetworkType;

.field public static final enum NETWORK_WIFI:Lcom/rokid/utils/NetworkUtlis$NetworkType;


# instance fields
.field private value:I


# direct methods
.method static constructor <clinit>()V
    .locals 4

    .line 25
    new-instance v0, Lcom/rokid/utils/NetworkUtlis$NetworkType;

    const-string v1, "NETWORK_NONE"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2, v2}, Lcom/rokid/utils/NetworkUtlis$NetworkType;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/rokid/utils/NetworkUtlis$NetworkType;->NETWORK_NONE:Lcom/rokid/utils/NetworkUtlis$NetworkType;

    .line 26
    new-instance v0, Lcom/rokid/utils/NetworkUtlis$NetworkType;

    const-string v1, "NETWORK_MOBILE"

    const/4 v2, 0x1

    invoke-direct {v0, v1, v2, v2}, Lcom/rokid/utils/NetworkUtlis$NetworkType;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/rokid/utils/NetworkUtlis$NetworkType;->NETWORK_MOBILE:Lcom/rokid/utils/NetworkUtlis$NetworkType;

    .line 27
    new-instance v0, Lcom/rokid/utils/NetworkUtlis$NetworkType;

    const-string v1, "NETWORK_WIFI"

    const/4 v2, 0x2

    invoke-direct {v0, v1, v2, v2}, Lcom/rokid/utils/NetworkUtlis$NetworkType;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/rokid/utils/NetworkUtlis$NetworkType;->NETWORK_WIFI:Lcom/rokid/utils/NetworkUtlis$NetworkType;

    .line 28
    new-instance v0, Lcom/rokid/utils/NetworkUtlis$NetworkType;

    const-string v1, "NETWORK_ETHERNET"

    const/4 v2, 0x3

    invoke-direct {v0, v1, v2, v2}, Lcom/rokid/utils/NetworkUtlis$NetworkType;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/rokid/utils/NetworkUtlis$NetworkType;->NETWORK_ETHERNET:Lcom/rokid/utils/NetworkUtlis$NetworkType;

    .line 23
    sget-object v0, Lcom/rokid/utils/NetworkUtlis$NetworkType;->NETWORK_NONE:Lcom/rokid/utils/NetworkUtlis$NetworkType;

    sget-object v1, Lcom/rokid/utils/NetworkUtlis$NetworkType;->NETWORK_MOBILE:Lcom/rokid/utils/NetworkUtlis$NetworkType;

    sget-object v2, Lcom/rokid/utils/NetworkUtlis$NetworkType;->NETWORK_WIFI:Lcom/rokid/utils/NetworkUtlis$NetworkType;

    sget-object v3, Lcom/rokid/utils/NetworkUtlis$NetworkType;->NETWORK_ETHERNET:Lcom/rokid/utils/NetworkUtlis$NetworkType;

    filled-new-array {v0, v1, v2, v3}, [Lcom/rokid/utils/NetworkUtlis$NetworkType;

    move-result-object v0

    sput-object v0, Lcom/rokid/utils/NetworkUtlis$NetworkType;->$VALUES:[Lcom/rokid/utils/NetworkUtlis$NetworkType;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;II)V
    .locals 0
    .param p3, "value"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I)V"
        }
    .end annotation

    .line 32
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    .line 30
    const/4 p1, 0x0

    iput p1, p0, Lcom/rokid/utils/NetworkUtlis$NetworkType;->value:I

    .line 33
    iput p3, p0, Lcom/rokid/utils/NetworkUtlis$NetworkType;->value:I

    .line 34
    return-void
.end method

.method static synthetic access$000(Lcom/rokid/utils/NetworkUtlis$NetworkType;)I
    .locals 1
    .param p0, "x0"    # Lcom/rokid/utils/NetworkUtlis$NetworkType;

    .line 23
    iget v0, p0, Lcom/rokid/utils/NetworkUtlis$NetworkType;->value:I

    return v0
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/rokid/utils/NetworkUtlis$NetworkType;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .line 23
    const-class v0, Lcom/rokid/utils/NetworkUtlis$NetworkType;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/rokid/utils/NetworkUtlis$NetworkType;

    return-object v0
.end method

.method public static values()[Lcom/rokid/utils/NetworkUtlis$NetworkType;
    .locals 1

    .line 23
    sget-object v0, Lcom/rokid/utils/NetworkUtlis$NetworkType;->$VALUES:[Lcom/rokid/utils/NetworkUtlis$NetworkType;

    invoke-virtual {v0}, [Lcom/rokid/utils/NetworkUtlis$NetworkType;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/rokid/utils/NetworkUtlis$NetworkType;

    return-object v0
.end method


# virtual methods
.method public value()I
    .locals 1

    .line 37
    iget v0, p0, Lcom/rokid/utils/NetworkUtlis$NetworkType;->value:I

    return v0
.end method
