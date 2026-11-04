.class Lcom/rokid/aicore/utils/FrameImageCache$1;
.super Ljava/util/LinkedHashMap;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/aicore/utils/FrameImageCache;-><init>(I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/util/LinkedHashMap<",
        "Ljava/lang/Long;",
        "Lcom/rokid/aicore/api/bean/ImageInput;",
        ">;"
    }
.end annotation


# instance fields
.field public final synthetic this$0:Lcom/rokid/aicore/utils/FrameImageCache;


# direct methods
.method public constructor <init>(Lcom/rokid/aicore/utils/FrameImageCache;IFZ)V
    .locals 0

    iput-object p1, p0, Lcom/rokid/aicore/utils/FrameImageCache$1;->this$0:Lcom/rokid/aicore/utils/FrameImageCache;

    invoke-direct {p0, p2, p3, p4}, Ljava/util/LinkedHashMap;-><init>(IFZ)V

    return-void
.end method


# virtual methods
.method public removeEldestEntry(Ljava/util/Map$Entry;)Z
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map$Entry<",
            "Ljava/lang/Long;",
            "Lcom/rokid/aicore/api/bean/ImageInput;",
            ">;)Z"
        }
    .end annotation

    invoke-virtual {p0}, Ljava/util/LinkedHashMap;->size()I

    move-result p1

    iget-object v0, p0, Lcom/rokid/aicore/utils/FrameImageCache$1;->this$0:Lcom/rokid/aicore/utils/FrameImageCache;

    invoke-static {v0}, Lcom/rokid/aicore/utils/FrameImageCache;->access$000(Lcom/rokid/aicore/utils/FrameImageCache;)I

    move-result v0

    if-le p1, v0, :cond_0

    const/4 p1, 0x1

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    :goto_0
    return p1
.end method
