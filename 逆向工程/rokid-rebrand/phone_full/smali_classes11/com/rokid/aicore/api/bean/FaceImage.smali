.class public Lcom/rokid/aicore/api/bean/FaceImage;
.super Ljava/lang/Object;


# instance fields
.field private frameId:Ljava/lang/Long;

.field private tracks:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Ljava/util/ArrayList;Ljava/lang/Long;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/ArrayList<",
            "Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;",
            ">;",
            "Ljava/lang/Long;",
            ")V"
        }
    .end annotation

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/rokid/aicore/api/bean/FaceImage;->tracks:Ljava/util/ArrayList;

    iput-object p2, p0, Lcom/rokid/aicore/api/bean/FaceImage;->frameId:Ljava/lang/Long;

    return-void
.end method


# virtual methods
.method public getFrameId()Ljava/lang/Long;
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/api/bean/FaceImage;->frameId:Ljava/lang/Long;

    return-object v0
.end method

.method public getTracks()Ljava/util/ArrayList;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/ArrayList<",
            "Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lcom/rokid/aicore/api/bean/FaceImage;->tracks:Ljava/util/ArrayList;

    return-object v0
.end method
