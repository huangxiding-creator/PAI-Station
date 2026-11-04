.class public final enum Lio/minio/messages/QuoteFields;
.super Ljava/lang/Enum;
.source "QuoteFields.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lio/minio/messages/QuoteFields;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lio/minio/messages/QuoteFields;

.field public static final enum ALWAYS:Lio/minio/messages/QuoteFields;

.field public static final enum ASNEEDED:Lio/minio/messages/QuoteFields;


# direct methods
.method private static synthetic $values()[Lio/minio/messages/QuoteFields;
    .locals 2

    .line 20
    sget-object v0, Lio/minio/messages/QuoteFields;->ALWAYS:Lio/minio/messages/QuoteFields;

    sget-object v1, Lio/minio/messages/QuoteFields;->ASNEEDED:Lio/minio/messages/QuoteFields;

    filled-new-array {v0, v1}, [Lio/minio/messages/QuoteFields;

    move-result-object v0

    return-object v0
.end method

.method static constructor <clinit>()V
    .locals 3

    .line 21
    new-instance v0, Lio/minio/messages/QuoteFields;

    const-string v1, "ALWAYS"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lio/minio/messages/QuoteFields;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lio/minio/messages/QuoteFields;->ALWAYS:Lio/minio/messages/QuoteFields;

    .line 22
    new-instance v0, Lio/minio/messages/QuoteFields;

    const-string v1, "ASNEEDED"

    const/4 v2, 0x1

    invoke-direct {v0, v1, v2}, Lio/minio/messages/QuoteFields;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lio/minio/messages/QuoteFields;->ASNEEDED:Lio/minio/messages/QuoteFields;

    .line 20
    invoke-static {}, Lio/minio/messages/QuoteFields;->$values()[Lio/minio/messages/QuoteFields;

    move-result-object v0

    sput-object v0, Lio/minio/messages/QuoteFields;->$VALUES:[Lio/minio/messages/QuoteFields;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 20
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lio/minio/messages/QuoteFields;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .line 20
    const-class v0, Lio/minio/messages/QuoteFields;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lio/minio/messages/QuoteFields;

    return-object v0
.end method

.method public static values()[Lio/minio/messages/QuoteFields;
    .locals 1

    .line 20
    sget-object v0, Lio/minio/messages/QuoteFields;->$VALUES:[Lio/minio/messages/QuoteFields;

    invoke-virtual {v0}, [Lio/minio/messages/QuoteFields;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lio/minio/messages/QuoteFields;

    return-object v0
.end method
