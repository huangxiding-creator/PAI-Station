.class public final enum Lorg/xerial/snappy/BitShuffleType;
.super Ljava/lang/Enum;
.source "BitShuffleType.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lorg/xerial/snappy/BitShuffleType;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lorg/xerial/snappy/BitShuffleType;

.field public static final enum BYTE:Lorg/xerial/snappy/BitShuffleType;

.field public static final enum DOUBLE:Lorg/xerial/snappy/BitShuffleType;

.field public static final enum FLOAT:Lorg/xerial/snappy/BitShuffleType;

.field public static final enum INT:Lorg/xerial/snappy/BitShuffleType;

.field public static final enum LONG:Lorg/xerial/snappy/BitShuffleType;

.field public static final enum SHORT:Lorg/xerial/snappy/BitShuffleType;


# instance fields
.field public final id:I


# direct methods
.method static constructor <clinit>()V
    .locals 11

    .line 35
    new-instance v0, Lorg/xerial/snappy/BitShuffleType;

    const-string v1, "BYTE"

    const/4 v2, 0x0

    const/4 v3, 0x1

    invoke-direct {v0, v1, v2, v3}, Lorg/xerial/snappy/BitShuffleType;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lorg/xerial/snappy/BitShuffleType;->BYTE:Lorg/xerial/snappy/BitShuffleType;

    .line 36
    new-instance v0, Lorg/xerial/snappy/BitShuffleType;

    const-string v1, "SHORT"

    const/4 v2, 0x2

    invoke-direct {v0, v1, v3, v2}, Lorg/xerial/snappy/BitShuffleType;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lorg/xerial/snappy/BitShuffleType;->SHORT:Lorg/xerial/snappy/BitShuffleType;

    .line 37
    new-instance v0, Lorg/xerial/snappy/BitShuffleType;

    const-string v1, "INT"

    const/4 v3, 0x4

    invoke-direct {v0, v1, v2, v3}, Lorg/xerial/snappy/BitShuffleType;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lorg/xerial/snappy/BitShuffleType;->INT:Lorg/xerial/snappy/BitShuffleType;

    .line 38
    new-instance v0, Lorg/xerial/snappy/BitShuffleType;

    const-string v1, "LONG"

    const/4 v2, 0x3

    const/16 v4, 0x8

    invoke-direct {v0, v1, v2, v4}, Lorg/xerial/snappy/BitShuffleType;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lorg/xerial/snappy/BitShuffleType;->LONG:Lorg/xerial/snappy/BitShuffleType;

    .line 39
    new-instance v0, Lorg/xerial/snappy/BitShuffleType;

    const-string v1, "FLOAT"

    invoke-direct {v0, v1, v3, v3}, Lorg/xerial/snappy/BitShuffleType;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lorg/xerial/snappy/BitShuffleType;->FLOAT:Lorg/xerial/snappy/BitShuffleType;

    .line 40
    new-instance v0, Lorg/xerial/snappy/BitShuffleType;

    const-string v1, "DOUBLE"

    const/4 v2, 0x5

    invoke-direct {v0, v1, v2, v4}, Lorg/xerial/snappy/BitShuffleType;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lorg/xerial/snappy/BitShuffleType;->DOUBLE:Lorg/xerial/snappy/BitShuffleType;

    .line 32
    sget-object v5, Lorg/xerial/snappy/BitShuffleType;->BYTE:Lorg/xerial/snappy/BitShuffleType;

    sget-object v6, Lorg/xerial/snappy/BitShuffleType;->SHORT:Lorg/xerial/snappy/BitShuffleType;

    sget-object v7, Lorg/xerial/snappy/BitShuffleType;->INT:Lorg/xerial/snappy/BitShuffleType;

    sget-object v8, Lorg/xerial/snappy/BitShuffleType;->LONG:Lorg/xerial/snappy/BitShuffleType;

    sget-object v9, Lorg/xerial/snappy/BitShuffleType;->FLOAT:Lorg/xerial/snappy/BitShuffleType;

    sget-object v10, Lorg/xerial/snappy/BitShuffleType;->DOUBLE:Lorg/xerial/snappy/BitShuffleType;

    filled-new-array/range {v5 .. v10}, [Lorg/xerial/snappy/BitShuffleType;

    move-result-object v0

    sput-object v0, Lorg/xerial/snappy/BitShuffleType;->$VALUES:[Lorg/xerial/snappy/BitShuffleType;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;II)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I)V"
        }
    .end annotation

    .line 45
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    .line 46
    iput p3, p0, Lorg/xerial/snappy/BitShuffleType;->id:I

    .line 47
    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lorg/xerial/snappy/BitShuffleType;
    .locals 1

    .line 32
    const-class v0, Lorg/xerial/snappy/BitShuffleType;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lorg/xerial/snappy/BitShuffleType;

    return-object p0
.end method

.method public static values()[Lorg/xerial/snappy/BitShuffleType;
    .locals 1

    .line 32
    sget-object v0, Lorg/xerial/snappy/BitShuffleType;->$VALUES:[Lorg/xerial/snappy/BitShuffleType;

    invoke-virtual {v0}, [Lorg/xerial/snappy/BitShuffleType;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lorg/xerial/snappy/BitShuffleType;

    return-object v0
.end method


# virtual methods
.method public getTypeSize()I
    .locals 1

    .line 51
    iget v0, p0, Lorg/xerial/snappy/BitShuffleType;->id:I

    return v0
.end method
