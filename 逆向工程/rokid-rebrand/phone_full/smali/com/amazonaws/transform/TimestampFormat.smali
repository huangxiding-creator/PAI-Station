.class public final enum Lcom/amazonaws/transform/TimestampFormat;
.super Ljava/lang/Enum;
.source "TimestampFormat.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/amazonaws/transform/TimestampFormat;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/amazonaws/transform/TimestampFormat;

.field public static final enum ISO_8601:Lcom/amazonaws/transform/TimestampFormat;

.field public static final enum RFC_822:Lcom/amazonaws/transform/TimestampFormat;

.field public static final enum UNIX_TIMESTAMP:Lcom/amazonaws/transform/TimestampFormat;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .line 27
    new-instance v0, Lcom/amazonaws/transform/TimestampFormat;

    const-string v1, "UNIX_TIMESTAMP"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/amazonaws/transform/TimestampFormat;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/amazonaws/transform/TimestampFormat;->UNIX_TIMESTAMP:Lcom/amazonaws/transform/TimestampFormat;

    .line 33
    new-instance v0, Lcom/amazonaws/transform/TimestampFormat;

    const-string v1, "ISO_8601"

    const/4 v2, 0x1

    invoke-direct {v0, v1, v2}, Lcom/amazonaws/transform/TimestampFormat;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/amazonaws/transform/TimestampFormat;->ISO_8601:Lcom/amazonaws/transform/TimestampFormat;

    .line 38
    new-instance v0, Lcom/amazonaws/transform/TimestampFormat;

    const-string v1, "RFC_822"

    const/4 v2, 0x2

    invoke-direct {v0, v1, v2}, Lcom/amazonaws/transform/TimestampFormat;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/amazonaws/transform/TimestampFormat;->RFC_822:Lcom/amazonaws/transform/TimestampFormat;

    .line 23
    sget-object v0, Lcom/amazonaws/transform/TimestampFormat;->UNIX_TIMESTAMP:Lcom/amazonaws/transform/TimestampFormat;

    sget-object v1, Lcom/amazonaws/transform/TimestampFormat;->ISO_8601:Lcom/amazonaws/transform/TimestampFormat;

    sget-object v2, Lcom/amazonaws/transform/TimestampFormat;->RFC_822:Lcom/amazonaws/transform/TimestampFormat;

    filled-new-array {v0, v1, v2}, [Lcom/amazonaws/transform/TimestampFormat;

    move-result-object v0

    sput-object v0, Lcom/amazonaws/transform/TimestampFormat;->$VALUES:[Lcom/amazonaws/transform/TimestampFormat;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 23
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/amazonaws/transform/TimestampFormat;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .line 23
    const-class v0, Lcom/amazonaws/transform/TimestampFormat;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/amazonaws/transform/TimestampFormat;

    return-object v0
.end method

.method public static values()[Lcom/amazonaws/transform/TimestampFormat;
    .locals 1

    .line 23
    sget-object v0, Lcom/amazonaws/transform/TimestampFormat;->$VALUES:[Lcom/amazonaws/transform/TimestampFormat;

    invoke-virtual {v0}, [Lcom/amazonaws/transform/TimestampFormat;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/amazonaws/transform/TimestampFormat;

    return-object v0
.end method
