.class public final enum Lorg/xerial/snappy/SnappyErrorCode;
.super Ljava/lang/Enum;
.source "SnappyErrorCode.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lorg/xerial/snappy/SnappyErrorCode;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lorg/xerial/snappy/SnappyErrorCode;

.field public static final enum EMPTY_INPUT:Lorg/xerial/snappy/SnappyErrorCode;

.field public static final enum FAILED_TO_LOAD_NATIVE_LIBRARY:Lorg/xerial/snappy/SnappyErrorCode;

.field public static final enum FAILED_TO_UNCOMPRESS:Lorg/xerial/snappy/SnappyErrorCode;

.field public static final enum INCOMPATIBLE_VERSION:Lorg/xerial/snappy/SnappyErrorCode;

.field public static final enum INVALID_CHUNK_SIZE:Lorg/xerial/snappy/SnappyErrorCode;

.field public static final enum NOT_A_DIRECT_BUFFER:Lorg/xerial/snappy/SnappyErrorCode;

.field public static final enum OUT_OF_MEMORY:Lorg/xerial/snappy/SnappyErrorCode;

.field public static final enum PARSING_ERROR:Lorg/xerial/snappy/SnappyErrorCode;

.field public static final enum UNKNOWN:Lorg/xerial/snappy/SnappyErrorCode;


# instance fields
.field public final id:I


# direct methods
.method static constructor <clinit>()V
    .locals 12

    .line 36
    new-instance v0, Lorg/xerial/snappy/SnappyErrorCode;

    const-string v1, "UNKNOWN"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2, v2}, Lorg/xerial/snappy/SnappyErrorCode;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lorg/xerial/snappy/SnappyErrorCode;->UNKNOWN:Lorg/xerial/snappy/SnappyErrorCode;

    .line 37
    new-instance v0, Lorg/xerial/snappy/SnappyErrorCode;

    const-string v1, "FAILED_TO_LOAD_NATIVE_LIBRARY"

    const/4 v2, 0x1

    invoke-direct {v0, v1, v2, v2}, Lorg/xerial/snappy/SnappyErrorCode;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lorg/xerial/snappy/SnappyErrorCode;->FAILED_TO_LOAD_NATIVE_LIBRARY:Lorg/xerial/snappy/SnappyErrorCode;

    .line 38
    new-instance v0, Lorg/xerial/snappy/SnappyErrorCode;

    const-string v1, "PARSING_ERROR"

    const/4 v2, 0x2

    invoke-direct {v0, v1, v2, v2}, Lorg/xerial/snappy/SnappyErrorCode;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lorg/xerial/snappy/SnappyErrorCode;->PARSING_ERROR:Lorg/xerial/snappy/SnappyErrorCode;

    .line 39
    new-instance v0, Lorg/xerial/snappy/SnappyErrorCode;

    const-string v1, "NOT_A_DIRECT_BUFFER"

    const/4 v2, 0x3

    invoke-direct {v0, v1, v2, v2}, Lorg/xerial/snappy/SnappyErrorCode;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lorg/xerial/snappy/SnappyErrorCode;->NOT_A_DIRECT_BUFFER:Lorg/xerial/snappy/SnappyErrorCode;

    .line 40
    new-instance v0, Lorg/xerial/snappy/SnappyErrorCode;

    const-string v1, "OUT_OF_MEMORY"

    const/4 v2, 0x4

    invoke-direct {v0, v1, v2, v2}, Lorg/xerial/snappy/SnappyErrorCode;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lorg/xerial/snappy/SnappyErrorCode;->OUT_OF_MEMORY:Lorg/xerial/snappy/SnappyErrorCode;

    .line 41
    new-instance v0, Lorg/xerial/snappy/SnappyErrorCode;

    const-string v1, "FAILED_TO_UNCOMPRESS"

    const/4 v2, 0x5

    invoke-direct {v0, v1, v2, v2}, Lorg/xerial/snappy/SnappyErrorCode;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lorg/xerial/snappy/SnappyErrorCode;->FAILED_TO_UNCOMPRESS:Lorg/xerial/snappy/SnappyErrorCode;

    .line 42
    new-instance v0, Lorg/xerial/snappy/SnappyErrorCode;

    const-string v1, "EMPTY_INPUT"

    const/4 v2, 0x6

    invoke-direct {v0, v1, v2, v2}, Lorg/xerial/snappy/SnappyErrorCode;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lorg/xerial/snappy/SnappyErrorCode;->EMPTY_INPUT:Lorg/xerial/snappy/SnappyErrorCode;

    .line 43
    new-instance v0, Lorg/xerial/snappy/SnappyErrorCode;

    const-string v1, "INCOMPATIBLE_VERSION"

    const/4 v2, 0x7

    invoke-direct {v0, v1, v2, v2}, Lorg/xerial/snappy/SnappyErrorCode;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lorg/xerial/snappy/SnappyErrorCode;->INCOMPATIBLE_VERSION:Lorg/xerial/snappy/SnappyErrorCode;

    .line 44
    new-instance v0, Lorg/xerial/snappy/SnappyErrorCode;

    const-string v1, "INVALID_CHUNK_SIZE"

    const/16 v2, 0x8

    invoke-direct {v0, v1, v2, v2}, Lorg/xerial/snappy/SnappyErrorCode;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lorg/xerial/snappy/SnappyErrorCode;->INVALID_CHUNK_SIZE:Lorg/xerial/snappy/SnappyErrorCode;

    .line 32
    sget-object v3, Lorg/xerial/snappy/SnappyErrorCode;->UNKNOWN:Lorg/xerial/snappy/SnappyErrorCode;

    sget-object v4, Lorg/xerial/snappy/SnappyErrorCode;->FAILED_TO_LOAD_NATIVE_LIBRARY:Lorg/xerial/snappy/SnappyErrorCode;

    sget-object v5, Lorg/xerial/snappy/SnappyErrorCode;->PARSING_ERROR:Lorg/xerial/snappy/SnappyErrorCode;

    sget-object v6, Lorg/xerial/snappy/SnappyErrorCode;->NOT_A_DIRECT_BUFFER:Lorg/xerial/snappy/SnappyErrorCode;

    sget-object v7, Lorg/xerial/snappy/SnappyErrorCode;->OUT_OF_MEMORY:Lorg/xerial/snappy/SnappyErrorCode;

    sget-object v8, Lorg/xerial/snappy/SnappyErrorCode;->FAILED_TO_UNCOMPRESS:Lorg/xerial/snappy/SnappyErrorCode;

    sget-object v9, Lorg/xerial/snappy/SnappyErrorCode;->EMPTY_INPUT:Lorg/xerial/snappy/SnappyErrorCode;

    sget-object v10, Lorg/xerial/snappy/SnappyErrorCode;->INCOMPATIBLE_VERSION:Lorg/xerial/snappy/SnappyErrorCode;

    sget-object v11, Lorg/xerial/snappy/SnappyErrorCode;->INVALID_CHUNK_SIZE:Lorg/xerial/snappy/SnappyErrorCode;

    filled-new-array/range {v3 .. v11}, [Lorg/xerial/snappy/SnappyErrorCode;

    move-result-object v0

    sput-object v0, Lorg/xerial/snappy/SnappyErrorCode;->$VALUES:[Lorg/xerial/snappy/SnappyErrorCode;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;II)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I)V"
        }
    .end annotation

    .line 49
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    .line 50
    iput p3, p0, Lorg/xerial/snappy/SnappyErrorCode;->id:I

    .line 51
    return-void
.end method

.method public static getErrorCode(I)Lorg/xerial/snappy/SnappyErrorCode;
    .locals 5

    .line 55
    invoke-static {}, Lorg/xerial/snappy/SnappyErrorCode;->values()[Lorg/xerial/snappy/SnappyErrorCode;

    move-result-object v0

    array-length v1, v0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_1

    aget-object v3, v0, v2

    .line 56
    iget v4, v3, Lorg/xerial/snappy/SnappyErrorCode;->id:I

    if-ne v4, p0, :cond_0

    .line 57
    return-object v3

    .line 55
    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 60
    :cond_1
    sget-object p0, Lorg/xerial/snappy/SnappyErrorCode;->UNKNOWN:Lorg/xerial/snappy/SnappyErrorCode;

    return-object p0
.end method

.method public static getErrorMessage(I)Ljava/lang/String;
    .locals 0

    .line 65
    invoke-static {p0}, Lorg/xerial/snappy/SnappyErrorCode;->getErrorCode(I)Lorg/xerial/snappy/SnappyErrorCode;

    move-result-object p0

    invoke-virtual {p0}, Lorg/xerial/snappy/SnappyErrorCode;->name()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static valueOf(Ljava/lang/String;)Lorg/xerial/snappy/SnappyErrorCode;
    .locals 1

    .line 32
    const-class v0, Lorg/xerial/snappy/SnappyErrorCode;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lorg/xerial/snappy/SnappyErrorCode;

    return-object p0
.end method

.method public static values()[Lorg/xerial/snappy/SnappyErrorCode;
    .locals 1

    .line 32
    sget-object v0, Lorg/xerial/snappy/SnappyErrorCode;->$VALUES:[Lorg/xerial/snappy/SnappyErrorCode;

    invoke-virtual {v0}, [Lorg/xerial/snappy/SnappyErrorCode;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lorg/xerial/snappy/SnappyErrorCode;

    return-object v0
.end method
